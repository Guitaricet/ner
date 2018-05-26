python3 noise_experiment.py --dataset conll2003 --results-filename conll_noembed_moreNL.csv
python3 noise_experiment.py --dataset conll2003 --results-filename --no-char-embeddings conll_noembed_nochar.csv
python3 noise_experiment.py --dataset conll2003 --results-filename --embeddings /media/data/nlp/data/wiki.en.bin --no-char-embeddings conll_fasttext_nochar.csv
python3 noise_experiment.py --dataset conll2003 --results-filename conll_noembed_gru.csv
python3 noise_experiment.py --dataset conll2003 --results-filename --embeddings /media/data/nlp/data/wiki.en.bin conll_fasttext_gru.csv
python3 noise_experiment.py --dataset conll2003 --results-filename --no-char-embeddings conll_noembed_nochar_gru.csv
python3 noise_experiment.py --dataset conll2003 --results-filename --embeddings /media/data/nlp/data/wiki.en.bin --no-char-embeddings conll_fasttext_nochar_gru.csv
