# echo -e "\nCollection5\n"
# python3 noise_experiment.py --dataset data/collection5 --results-filename results/collection5_noembed.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --results-filename results/collection5_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_nochar.csv
# echo -e "\nCollection5 Fixed Word2Vec\n"
# python3 noise_experiment.py --dataset data/collection5 --embeddings-format word2vec --embeddings /media/data/nlp/data/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag --results-filename results/collection5_word2vec_fixed.csv
# python3 noise_experiment.py --ataset data/collection5 --embeddings-format word2vec --embeddings /media/data/nlp/data/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag  --no-char-embeddings --results-filename results/collection5_word2vec_fixed_nochar.csv
# echo -e "\nCollection5 GRU network\n"
# python3 noise_experiment.py --dataset data/collection5 --network-type gru --results-filename results/collection5_noembed_grunet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type gru --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_grunet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type gru --no-char-embeddings --results-filename results/collection5_noembed_nochar_grunet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type gru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/collection5_fasttext_nochar_grunet.csv

echo -e "\nFactRU\n"
python3 noise_experiment.py --dataset data/factru --results-filename results/factru_noembed.csv
python3 noise_experiment.py --dataset data/factru --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/factru_fasttext.csv
python3 noise_experiment.py --dataset data/factru --no-char-embeddings --results-filename results/factru_noembed_nochar.csv
python3 noise_experiment.py --dataset data/factru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.ru.bin --results-filename results/factru_fasttext_nochar.csv

# echo -e "\nCONLL\n"
# python3 noise_experiment.py --dataset data/conll2003 --results-filename results/conll2003_noembed.csv
# python3 noise_experiment.py --dataset data/conll2003 --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext.csv
# python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --results-filename results/conll2003_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_nochar.csv
# echo -e "\nCONLL GRU network\n"
# python3 noise_experiment.py --dataset data/conll2003 --network-type gru --results-filename results/conll2003_noembed_grunet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type gru --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_grunet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type gru --no-char-embeddings --results-filename results/conll2003_noembed_nochar_grunet.csv
# python3 noise_experiment.py --dataset data/conll2003 --network-type gru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/conll2003_fasttext_nochar_grunet.csv
# echo -e "\nCONLL Fixed Word2Vec\n"
# python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin --results-filename results/conll_word2vec_fixed.csv
# python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin  --no-char-embeddings --results-filename results/conll_word2vec_fixed_nochar.csv
