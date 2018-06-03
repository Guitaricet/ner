# echo -e "\nCollection5\n"
# python3 noise_experiment.py --dataset data/collection5 --results-filename results/collection5_noembed.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --results-filename results/collection5_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_nochar.csv

# echo -e "\nCollection5 Fixed Word2Vec\n"
# python3 noise_experiment.py --dataset data/collection5 --embeddings-format word2vec --embeddings /media/data/nlp/data/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag --results-filename results/collection5_word2vec_fixed.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings-format word2vec --embeddings /media/data/nlp/data/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag  --no-char-embeddings --results-filename results/collection5_word2vec_fixed_nochar.csv

# echo -e "\nCollection5 LSTM network\n"
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --no-char-embeddings --results-filename results/collection5_noembed_nochar_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_nochar_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --results-filename results/collection5_noembed_lstmnet.csv

# echo -e "\nFactRU\n"
# python3 noise_experiment.py --epochs 30 --dataset data/factru --results-filename results/factru_noembed_30epochs.csv
# python3 noise_experiment.py --epochs 30 --dataset data/factru --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/factru_fasttext_30epochs.csv
# python3 noise_experiment.py --epochs 30 --dataset data/factru --no-char-embeddings --results-filename results/factru_noembed_nochar_30epochs.csv
# python3 noise_experiment.py --epochs 30 --dataset data/factru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/factru_fasttext_nochar_30epochs.csv

# echo -e "\nCONLL\n"
# python3 noise_experiment.py --dataset data/conll2003 --results-filename results/conll2003_noembed.csv
# python3 noise_experiment.py --dataset data/conll2003 --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext.csv
# python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --results-filename results/conll2003_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_nochar.csv

# echo -e "\nCONLL lstm network\n"
# python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --results-filename results/conll2003_noembed_lstmnet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_lstmnet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --no-char-embeddings --results-filename results/conll2003_noembed_nochar_lstmnet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_nochar_lstmnet.csv

# echo -e "\nCONLL Fixed Word2Vec\n"
# python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin --results-filename results/conll_word2vec_fixed.csv
# python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin  --no-char-embeddings --results-filename results/conll_word2vec_fixed_nochar.csv

echo -e "\CAp\n"
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed.csv
python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --no-char-embeddings --results-filename results/CAp_noembed_nochar.csv
python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /media/data/nlp/data/wiki.fr.bin --results-filename results/CAp_fasttext.csv
python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /media/data/nlp/data/wiki.fr.bin --no-char-embeddings --results-filename results/CAp_fasttext_nochar.csv
