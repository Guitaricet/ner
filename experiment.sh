echo "\nCollection5\n"
python3 noise_experiment.py --dataset collection5 --results-filename collection5_noembed.csv
python3 noise_experiment.py --dataset collection5 --embeddings /media/data/nlp/data/wiki.en.bin --results-filename collection5_fasttext_nochar.csv
python3 noise_experiment.py --dataset collection5 --no-char-embeddings --results-filename collection5_noembed_nochar.csv
python3 noise_experiment.py --dataset collection5 --no-char-embeddings --results-filename --embeddings /media/data/nlp/data/wiki.en.bin collection5_fasttext_nochar.csv
echo "\nCollection5 GRU network\n"
python3 noise_experiment.py --dataset collection5 --network-type gru --results-filename collection5_noembed_grunet.csv
python3 noise_experiment.py --dataset collection5 --network-type gru --embeddings /media/data/nlp/data/wiki.en.bin --results-filename collection5_fasttext_grunet.csv
python3 noise_experiment.py --dataset collection5 --network-type gru --no-char-embeddings --results-filename collection5_noembed_nochar_grunet.csv
python3 noise_experiment.py --dataset collection5 --network-type gru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename collection5_fasttext_nochar_grunet.csv
# echo "\nCONLL\n"
# python3 noise_experiment.py --dataset conll2003 --results-filename conll2003_noembed.csv
# python3 noise_experiment.py --dataset conll2003 --embeddings /media/data/nlp/data/wiki.en.bin --results-filename conll2003_fasttext_nochar.csv
# python3 noise_experiment.py --dataset conll2003 --no-char-embeddings --results-filename conll2003_noembed_nochar.csv
# python3 noise_experiment.py --dataset conll2003 --no-char-embeddings --results-filename --embeddings /media/data/nlp/data/wiki.en.bin conll2003_fasttext_nochar.csv
echo "\nCONLL GRU network\n"
python3 noise_experiment.py --dataset conll2003 --network-type gru --results-filename conll2003_noembed_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --embeddings /media/data/nlp/data/wiki.en.bin --results-filename conll2003_fasttext_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --no-char-embeddings --results-filename conll2003_noembed_nochar_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename conll2003_fasttext_nochar_grunet.csv
