python3 noise_experiment.py --dataset data/collection5 --results-filename results/collection5_noembed.csv
python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --results-filename results/collection5_noembed_nochar.csv
python3 noise_experiment.py --dataset data/collection5 --not-trainable-embeddings --results-filename results/collection5_noembed_not_trainable.csv
python3 noise_experiment.py --dataset data/collection5 --not-trainable-embeddings --no-char-embeddings --results-filename results/collection5_noembed_not_trainable_nochar.csv

python3 noise_experiment.py --dataset data/collection5 --network-type lstm --results-filename results/collection5_noembed_lstmnet.csv
python3 noise_experiment.py --dataset data/collection5 --network-type lstm --no-char-embeddings --results-filename results/collection5_noembed_nochar_lstmnet.csv
