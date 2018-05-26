import logging
import argparse
from time import time

import numpy as np
import pandas as pd

from ner.corpus import Corpus
from ner.network import NER


formatter = logging.Formatter(
    '%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
    datefmt='%m-%d %H:%M'
)
logger = logging.getLogger()

fileHandler = logging.FileHandler('noise_experiment.log')
fileHandler.setFormatter(formatter)
logger.addHandler(fileHandler)

consoleHandler = logging.StreamHandler()
consoleHandler.setFormatter(formatter)
logger.addHandler(consoleHandler)

logger.setLevel('DEBUG')

time_total = time()


NOISE_LEVELS = np.concatenate([np.arange(0, 0.05, 0.005), np.arange(0.05, 0.2, 0.01)])

parser = argparse.ArgumentParser()
parser.add_argument('--dataset', type=str)
parser.add_argument('--epochs', type=int, default=5)
parser.add_argument('--embeddings', type=str, default=None, help='path to fasttext embeddings')
parser.add_argument('--results-filename', type=str, default='noise_experiment_results.csv')
# parser.add_argument('--gpu', default=False, action='store_true')
# parser.add_argument('--use-capitalization', default=False, action='store_true')


def read_data(datapath):
    with open(datapath) as f:
        xy_list = list()
        tokens = list()
        tags = list()
        for line in f:
            items = line.split()
            if len(items) > 1 and '-DOCSTART-' not in items[0]:
                token, tag = items
                if token[0].isdigit():
                    tokens.append('#')
                else:
                    # is you want static noise, add it here
                    tokens.append(token.lower())
                tags.append(tag)
            elif len(tokens) > 0:
                xy_list.append((tokens, tags,))
                tokens = list()
                tags = list()
    return xy_list


if __name__ == '__main__':
    args = parser.parse_args()

    logging.info('Reading the data...')

    data_types = ['train', 'test', 'valid']
    dataset_dict = dict()
    for data_type in data_types:
        datapath = '{dataset}/splits/{data_type}.txt'.format(dataset=args.dataset, data_type=data_type)
        xy_list = read_data(datapath)
        dataset_dict[data_type] = xy_list

    for key in dataset_dict:
        logger.info('Number of samples (sentences) in {:<5}: {}'.format(key, len(dataset_dict[key])))

    logger.info('\nHere is a first two samples from the train part of the dataset:')
    first_two_train_samples = dataset_dict['train'][:2]
    for n, sample in enumerate(first_two_train_samples):
        # sample is a tuple of sentence_tokens and sentence_tags
        tokens, tags = sample
        logger.info('Sentence {}'.format(n))
        logger.info('Tokens:  {}'.format(tokens))
        logger.info('Tags:    {}'.format(tags))

    logging.info('Creating Corpus')

    corp = Corpus(dataset_dict, embeddings_file_path=args.embeddings)

    results_all = []

    for noise_level in NOISE_LEVELS:
        logging.info('Starting training for noise level %s' % noise_level)
        corp.noise_level = noise_level

        model_params = {"filter_width": 7,
                        "embeddings_dropout": True,
                        "n_filters": [
                            128, 128,
                        ],
                        "token_embeddings_dim": 300,
                        "char_embeddings_dim": 25,
                        "use_batch_norm": True,
                        "use_crf": True,
                        "net_type": 'cnn',
                        "use_capitalization": False,
                    }

        net = NER(corp, **model_params)

        learning_params = {'dropout_rate': 0.5,
                        'epochs': 5,
                        'learning_rate': 0.005,
                        'batch_size': 8,
                        'learning_rate_decay': 0.707
                        }

        results = net.fit(epochs=args.epochs, learning_rate=0.005, learning_rate_decay=0.707, batch_size=8, dropout_rate=0.5)
    
        logging.info('Evaluating the model..')
        results_dict = {'noise_level': noise_level}
        results_dict.update(model_params)
        results_dict.update(learning_params)
        results_dict.update({'noised_' + k: v for k, v in results['__total__'].items()})

        net.corpus.noise_level = 0

        results = net.eval_conll()
        results_dict.update({'clean_' + k: v for k, v in results['__total__'].items()})

        results_all.append(results_dict)
        logging.info('Saving results...')
        pd.DataFrame(results_all).to_csv(args.results_filename)

    logging.info('Total execution time: %s min' % (((time() - time_total) // 60)))
