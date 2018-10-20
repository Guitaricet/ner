"""
Copyright 2017 Neural Networks and Deep Learning lab, MIPT
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

from collections import Counter
from collections import defaultdict
import random
import numpy as np

from pymystem3 import Mystem


DATA_PATH = '/tmp/ner'
DOC_START_STRING = '-DOCSTART-'
SEED = 42
SPECIAL_TOKENS = ['<PAD>', '<UNK>']
SPECIAL_TAGS = ['<PAD>']

# from https://github.com/akutuzov/universal-pos-tags/blob/4653e8a9154e93fe2f417c7fdb7a357b7d6ce333/ru-rnc.map
RNC_2_UNIPOS = {
    'A': 'ADJ',
    'ADV': 'ADV',
    'ADVPRO': 'ADV',
    'ANUM': 'ADJ',
    'APRO': 'DET',
    'COM': 'ADJ',
    'CONJ': 'SCONJ',
    'INTJ': 'INTJ',
    'NONLEX': 'X',
    'NUM': 'NUM',
    'PART': 'PART',
    'PR': 'ADP',
    'S': 'NOUN',
    'SPRO': 'PRON',
    'UNKN': 'X',
    'V': 'VERB'
}

np.random.seed(SEED)
random.seed(SEED)


# Dictionary class. Each instance holds tags or tokens or characters and provides
# dictionary like functionality like indices to tokens and tokens to indices.
class Vocabulary:
    def __init__(self, tokens=None, default_token='<UNK>', is_tags=False):
        if is_tags:
            special_tokens = SPECIAL_TAGS
            self._t2i = dict()
        else:
            special_tokens = SPECIAL_TOKENS
            if default_token not in special_tokens:
                raise Exception('SPECIAL_TOKENS must contain <UNK> token!')
            # We set default ind to position of <UNK> in SPECIAL_TOKENS
            # because the tokens will be added to dict in the same order as
            # in SPECIAL_TOKENS
            default_ind = special_tokens.index('<UNK>')
            self._t2i = defaultdict(lambda: default_ind)
        self._i2t = list()
        self.frequencies = Counter()

        self.counter = 0
        for token in special_tokens:
            self._t2i[token] = self.counter
            self.frequencies[token] += 0
            self._i2t.append(token)
            self.counter += 1
        if tokens is not None:
            self.update_dict(tokens)

    def update_dict(self, tokens):
        for token in tokens:
            if token not in self._t2i:
                self._t2i[token] = self.counter
                self._i2t.append(token)
                self.counter += 1
            self.frequencies[token] += 1

    def idx2tok(self, idx):
        return self._i2t[idx]

    def idxs2toks(self, idxs, filter_paddings=False):
        toks = []
        for idx in idxs:
            if not filter_paddings or idx != self.tok2idx('<PAD>'):
                toks.append(self._i2t[idx])
        return toks

    def tok2idx(self, tok):
        return self._t2i[tok]


    def toks2idxs(self, toks):
        return [self._t2i[tok] for tok in toks]

    def batch_toks2batch_idxs(self, b_toks):
        max_len = max(len(toks) for toks in b_toks)
        # Create array filled with paddings
        batch = np.ones([len(b_toks), max_len]) * self.tok2idx('<PAD>')
        for n, tokens in enumerate(b_toks):
            idxs = self.toks2idxs(tokens)
            batch[n, :len(idxs)] = idxs
        return batch

    def batch_idxs2batch_toks(self, b_idxs, filter_paddings=False):
        return [self.idxs2toks(idxs, filter_paddings) for idxs in b_idxs]

    def is_pad(self, x_t):
        assert type(x_t) == np.ndarray
        return x_t == self.tok2idx('<PAD>')

    def __getitem__(self, key):
        return self._t2i[key]

    def __len__(self):
        return self.counter

    def __contains__(self, item):
        return item in self._t2i


class Corpus:
    def __init__(self,
                 dataset=None,
                 embeddings_file_path=None,
                 dicts_filepath=None,
                 embeddings_format='fasttext',
                 noise_level=0,
                 postag=False,
                 is_rove=False,
                 rove_vocab=None):
        self.noise_level = noise_level
        self.embeddings_format = embeddings_format
        self.postag = postag
        self.is_rove = is_rove
        self.m = Mystem()
        if rove_vocab is not None:
            self.rove_vocab = rove_vocab

        if dataset is not None:
            self.dataset = dataset
            self.token_dict = Vocabulary(self.get_tokens())
            self.tag_dict = Vocabulary(self.get_tags(), is_tags=True)
            self.char_dict = Vocabulary(self.get_characters())
            # if rove_vocab is not None:
            #     self.alphabet = list(self.rove_vocab.keys())
            # else:
            self.alphabet = list(self.char_dict._t2i.keys())
            print(self.alphabet)
        elif dicts_filepath is not None:
            self.dataset = None
            self.load_corpus_dicts(dicts_filepath)
        if embeddings_file_path is not None:
            self.embeddings = self.load_embeddings(embeddings_file_path, format_=embeddings_format)
        else:
            self.embeddings = None

    # All tokens for dictionary building
    def get_tokens(self, data_type='train'):
        for tokens, _ in self.dataset[data_type]:
            for token in tokens:
                yield token

    # All tags for dictionary building
    def get_tags(self, data_type=None):
        if data_type is None:
            data_types = self.dataset.keys()
        else:
            data_types = [data_type]
        for data_type in data_types:
            for _, tags in self.dataset[data_type]:
                for tag in tags:
                    yield tag

    # All characters for dictionary building
    def get_characters(self, data_type='train'):
        for tokens, _ in self.dataset[data_type]:
            for token in tokens:
                for character in token:
                    yield character

    # BME encoding for RoVe
    def letters2vec(self, word, dtype=np.uint8):
        base = np.zeros(len(self.rove_vocab), dtype=dtype)

        def update_vector(vector, char):
            if char in self.rove_vocab:
                vector[self.rove_vocab.get(char, 0)] += 1

        middle = np.copy(base)
        for char in word:
            update_vector(middle, char)

        first = np.copy(base)
        update_vector(first, word[0])
        second = np.copy(base)
        if len(word) > 1:
            update_vector(second, word[1])
        third = np.copy(base)
        if len(word) > 2:
            update_vector(third, word[2])

        end_first = np.copy(base)
        update_vector(end_first, word[-1])
        end_second = np.copy(base)
        if len(word) > 1:
            update_vector(end_second, word[-2])
        end_third = np.copy(base)
        if len(word) > 2:
            update_vector(end_third, word[-3])

        return np.concatenate([first, second, third, middle, end_third, end_second, end_first])

    def load_embeddings(self, file_path, format_='fasttext'):
        # Embeddins must be in fastText format either bin or
        print('Loading embeddins...')
        if format_ == 'fasttext':
            from gensim.models.wrappers import FastText
            embeddings = FastText.load_fasttext_format(file_path)
        elif format_ == 'word2vec':
            from gensim.models import KeyedVectors
            try:
                embeddings = KeyedVectors.load_word2vec_format(file_path)
            except UnicodeDecodeError:
                embeddings = KeyedVectors.load_word2vec_format(file_path, binary=True)
        else:
            raise ValueError('format should be fasttext or word2vec, but format=%s' % format_)

        print('Embeddings are loaded')
        return embeddings

    def tokens_to_x_and_xc(self, tokens):
        n_tokens = len(tokens)
        tok_idxs = self.token_dict.toks2idxs(tokens)
        char_idxs = []
        max_char_len = 0
        for token in tokens:
            char_idxs.append(self.char_dict.toks2idxs(token))
            max_char_len = max(max_char_len, len(token))
        toks = np.zeros([1, n_tokens], dtype=np.int32)
        chars = np.zeros([1, n_tokens, max_char_len], dtype=np.int32)
        toks[0, :] = tok_idxs
        for n, char_line in enumerate(char_idxs):
            chars[0, n, :len(char_line)] = char_line
        return toks, chars

    def pos_tag_russian_per_sentence(self, tokens):
        return [self.pos_tag_russian(token) for token in tokens]

    # from https://github.com/RaRe-Technologies/gensim-data/issues/3
    def pos_tag_russian(self, word):
        """
        This function is needed for RusVectores w2v models
        """
        try:
            processed = self.m.analyze(word)[0]
            lemma = processed["analysis"][0]["lex"].lower().strip()
            pos = processed["analysis"][0]["gr"].split(',')[0]
            pos = pos.split('=')[0].strip()
            # convert to Universal Dependencies POS tag format:
            pos = RNC_2_UNIPOS[pos]
            tagged = lemma+'_'+pos
        except (KeyError, IndexError) as e:
            return word + '_X'  # UNK token

        return tagged

    def _noise_generator_per_sentence(self, tokens):
        noised_tokens = []
        for token in tokens:
            assert len(token) > 0
            noised_token = self._noise_generator(token)
            assert len(noised_token) > 0, (token, noised_token)
            noised_tokens.append(noised_token)
        return noised_tokens

    def _noise_generator(self, string):
        assert isinstance(string, str)
        noised = ""
        for c in string:
            if random.random() > self.noise_level:
                noised += c
            else:
                noised += random.choice(self.alphabet)
        return noised

    def batch_generator(self,
                        batch_size,
                        dataset_type='train',
                        shuffle=True,
                        allow_smaller_last_batch=True):
        tokens_tags_pairs = self.dataset[dataset_type]
        n_samples = len(tokens_tags_pairs)
        if shuffle:
            order = np.random.permutation(n_samples)
        else:
            order = np.arange(n_samples)
        n_batches = n_samples // batch_size
        if allow_smaller_last_batch and n_samples % batch_size:
            n_batches += 1
        for k in range(n_batches):
            batch_start = k * batch_size
            batch_end = min((k + 1) * batch_size, n_samples)
            x_batch = [tokens_tags_pairs[ind][0] for ind in order[batch_start: batch_end]]
            # add noise
            if self.noise_level > 0:
                x_batch = [self._noise_generator_per_sentence(token) for token in x_batch]
            if self.postag:
                x_batch = [self.pos_tag_russian_per_sentence(noised) for noised in x_batch]

            y_batch = [tokens_tags_pairs[ind][1] for ind in order[batch_start: batch_end]]
            x, y = self.preprocess_batch(x_batch, y_batch)
            yield x, y

    def preprocess_batch(self, batch_x, batch_y=None):
        #
        # Prepare x batch
        #
        x = dict()
        # Determine dimensions
        batch_size = len(batch_x)
        if self.is_rove:
            max_utt_len = 32  # rove does not support variable length
            batch_x = [utt[:max_utt_len] for utt in batch_x]
            batch_y = [bio[:max_utt_len] for bio in batch_y]
        else:
            max_utt_len = max([len(utt) for utt in batch_x])
        # Fix batch with len 1 issue (https://github.com/deepmipt/ner/issues/4) 
        max_utt_len = max(max_utt_len, 2)
        max_token_len = max([len(token) for utt in batch_x for token in utt])

        # Check whether bin file is used (if so then embeddings will be prepared on the go using gensim)
        prepare_embeddings_onthego = self.embeddings is not None
        # Prepare numpy arrays
        if prepare_embeddings_onthego:  # If the embeddings is a fastText model
            x['emb'] = np.zeros([batch_size, max_utt_len, self.embeddings.vector_size], dtype=np.float32)

        if self.is_rove:
            x['BME'] = np.zeros([batch_size, max_utt_len, 7 * len(self.rove_vocab)])

        x['token'] = np.ones([batch_size, max_utt_len], dtype=np.int32) * self.token_dict['<PAD>']
        x['char'] = np.ones([batch_size, max_utt_len, max_token_len], dtype=np.int32) * self.char_dict['<PAD>']

        # Capitalization
        x['capitalization'] = np.zeros([batch_size, max_utt_len], dtype=np.float32)
        for n, utt in enumerate(batch_x):
            for k, tok in enumerate(utt):
                if len(tok) > 0 and tok[0].isupper():
                    x['capitalization'][n, k] = 1

        # Prepare x batch
        for n, utterance in enumerate(batch_x):
            if prepare_embeddings_onthego:
                utterance_vectors = np.zeros([len(utterance), self.embeddings.vector_size])
                for q, token in enumerate(utterance):
                    try:
                        if self.postag:
                            # postag is always capitalized
                            tag_idx = token.rfind('_')
                            token, tag = token[:tag_idx].lower(), token[tag_idx:]
                            token = token + tag
                            utterance_vectors[q] = self.embeddings[token]
                        else:
                            utterance_vectors[q] = self.embeddings[token.lower()]
                    except KeyError:
                        pass
                x['emb'][n, :len(utterance), :] = utterance_vectors
            if self.postag:
                # remove tags before indexing and char-embedding
                utterance = [u[:u.rfind('_')] for u in utterance]

            if self.is_rove:
                bmes = [self.letters2vec(w) for w in utterance]
                x['BME'][n, :len(utterance)] = bmes

            toks = self.token_dict.toks2idxs(utterance)
            x['token'][n, :len(utterance)] = toks
            for k, token in enumerate(utterance):
                x['char'][n, k, :len(token)] = self.char_dict.toks2idxs(token)

        # Mask for paddings
        x['mask'] = np.zeros([batch_size, max_utt_len], dtype=np.float32)
        for n in range(batch_size):
            x['mask'][n, :len(batch_x[n])] = 1

        #
        # Prepare y batch
        #
        if batch_y is not None:
            y = np.ones([batch_size, max_utt_len], dtype=np.int32) * self.tag_dict['<PAD>']
        else:
            y = None

        if batch_y is not None:
            for n, tags in enumerate(batch_y):
                y[n, :len(tags)] = self.tag_dict.toks2idxs(tags)

        return x, y

    def save_corpus_dicts(self, filename='dict.txt'):
        # Token dict
        token_dict = self.token_dict._i2t
        with open(filename, 'w', encoding="utf8") as f:
            f.write('-TOKEN-DICT-\n')
            for ind in range(len(token_dict)):
                f.write(token_dict[ind] + '\n')
            f.write('\n')

        # Tag dict
        token_dict = self.tag_dict._i2t
        with open(filename, 'a', encoding="utf8") as f:
            f.write('-TAG-DICT-\n')
            for ind in range(len(token_dict)):
                f.write(token_dict[ind] + '\n')
            f.write('\n')

        # Character dict
        token_dict = self.char_dict._i2t
        with open(filename, 'a', encoding="utf8") as f:
            f.write('-CHAR-DICT-\n')
            for ind in range(len(token_dict)):
                f.write(token_dict[ind] + '\n')
            f.write('\n')

    def load_corpus_dicts(self, filename='dict.txt'):
        with open(filename, encoding="utf8") as f:
            # Token dict
            tokens = list()
            line = f.readline()
            assert line.strip() == '-TOKEN-DICT-'
            while len(line) > 0:
                line = f.readline().strip()
                if len(line) > 0:
                    tokens.append(line)
            self.token_dict = Vocabulary(tokens)

            # Tag dictappend
            line = f.readline()
            tags = list()
            assert line.strip() == '-TAG-DICT-'
            while len(line) > 0:
                line = f.readline().strip()
                if len(line) > 0:
                    tags.append(line)
            self.tag_dict = Vocabulary(tags, is_tags=True)

            # Char dict
            line = f.readline()
            chars = list()
            assert line.strip() == '-CHAR-DICT-'
            while len(line) > 0:
                line = f.readline().strip()
                if len(line) > 0:
                    chars.append(line)
            self.char_dict = Vocabulary(chars)
