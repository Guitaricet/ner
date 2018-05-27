# python3 noise_experiment.py --dataset conll2003 --results-filename conll_noembed_moreNL.csv
# python3 noise_experiment.py --dataset conll2003 --no-char-embeddings --results-filename conll_noembed_nochar.csv
# python3 noise_experiment.py --dataset conll2003 --no-char-embeddings --results-filename --embeddings /media/data/nlp/data/wiki.en.bin conll_fasttext_nochar.csv
python3 noise_experiment.py --dataset conll2003 --results-filename conll_noembed_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --embeddings /media/data/nlp/data/wiki.en.bin --results-filename conll_fasttext_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --no-char-embeddings --results-filename conll_noembed_nochar_grunet.csv
python3 noise_experiment.py --dataset conll2003 --network-type gru --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename conll_fasttext_nochar_grunet.csv
