# echo -e "\nCollection5\n"
# python3 noise_experiment.py --dataset data/collection5 --results-filename results/collection5_noembed.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings /data/embeddings/wiki.ru.bin --results-filename results/collection5_fasttext.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --results-filename results/collection5_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/collection5 --no-char-embeddings --embeddings /data/embeddings/wiki.ru.bin --results-filename results/collection5_fasttext_nochar.csv
# python3 noise_experiment.py --dataset data/collection5 --not-trainable-embeddings --results-filename results/collection5_noembed_not_trainable.csv
# python3 noise_experiment.py --dataset data/collection5 --not-trainable-embeddings --no-char-embeddings --results-filename results/collection5_noembed_not_trainable_nochar.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings-format word2vec --embeddings /data/embeddings/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag --results-filename results/collection5_word2vec_fixed.csv
# python3 noise_experiment.py --dataset data/collection5 --embeddings-format word2vec --embeddings /data/embeddings/ruwikiruscorpora-nobigrams_upos_skipgram_300_5_2018.vec --postag  --no-char-embeddings --results-filename results/collection5_word2vec_fixed_nochar.csv

# echo -e "\nCollection5 LSTM network\n"
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --results-filename results/collection5_noembed_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --embeddings /data/embeddings/wiki.ru.bin --results-filename results/collection5_fasttext_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --no-char-embeddings --results-filename results/collection5_noembed_nochar_lstmnet.csv
# python3 noise_experiment.py --dataset data/collection5 --network-type lstm --no-char-embeddings --embeddings /data/embeddings/wiki.ru.bin --results-filename results/collection5_fasttext_nochar_lstmnet.csv
# TODO: word2vec embeddings?

echo -e "\nCONLL\n"
python3 noise_experiment.py --dataset data/conll2003 --results-filename results/conll2003_noembed.csv
python3 noise_experiment.py --dataset data/conll2003 --embeddings /data/embeddings/wiki.simple.bin --results-filename results/conll2003_fasttext.csv
python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --results-filename results/conll2003_noembed_nochar.csv
python3 noise_experiment.py --dataset data/conll2003 --no-char-embeddings --embeddings /data/embeddings/wiki.simple.bin --results-filename results/conll2003_fasttext_nochar.csv
python3 noise_experiment.py --dataset data/conll2003 --not-trainable-embeddings --results-filename results/conll2003_noembed_not_trainable.csv
python3 noise_experiment.py --dataset data/conll2003 --not-trainable-embeddings --no-char-embeddings --results-filename results/conll2003_noembed_not_trainable_nochar.csv
python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /data/embeddings/GoogleNews-vectors-negative300.bin --results-filename results/conll_word2vec_fixed.csv
python3 noise_experiment.py --dataset data/conll2003 --embeddings-format word2vec --embeddings /data/embeddings/GoogleNews-vectors-negative300.bin  --no-char-embeddings --results-filename results/conll_word2vec_fixed_nochar.csv


echo -e "\nCONLL lstm network\n"
python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --results-filename results/conll2003_noembed_lstmnet.csv
python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --no-char-embeddings --results-filename results/conll2003_noembed_nochar_lstmnet.csv
python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --embeddings /media/data/nlp/data/wiki.simple.bin --results-filename results/conll2003_fasttext_lstmnet.csv
python3 noise_experiment.py --dataset data/conll2003 --network-type lstm --no-char-embeddings --embeddings /media/data/nlp/data/wiki.simple.bin --results-filename results/conll2003_fasttext_nochar_lstmnet.csv

# echo -e "\CAp\n"
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --no-char-embeddings --results-filename results/CAp_noembed_nochar.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /data/embeddings/cc.fr.300.bin --results-filename results/CAp_fasttext.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /data/embeddings/cc.fr.300.bin --no-char-embeddings --results-filename results/CAp_fasttext_nochar.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --not-trainable-embeddings --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed_not_trainable.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --not-trainable-embeddings --no-char-embeddings --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed_not_trainable_nochar.csv

# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed_original.csv --noise 0
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --no-char-embeddings --results-filename results/CAp_noembed_nochar_original.csv --noise 0
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /data/embeddings/cc.fr.300.bin --results-filename results/CAp_fasttext_original.csv --noise 0
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --embeddings /data/embeddings/cc.fr.300.bin --no-char-embeddings --results-filename results/CAp_fasttext_nochar_original.csv --noise 0
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --not-trainable-embeddings --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed_not_trainable_original.csv --noise 0
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_original_dict.pkl --not-trainable-embeddings --no-char-embeddings --original-testset data/CAp/test_set_wlabels.txt --results-filename results/CAp_noembed_not_trainable_nochar_original.csv --noise 0

# echo -e "\nCAp lstm network\n"
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --network-type lstm --results-filename results/CAp_noembed_lstmnet.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --network-type lstm --no-char-embeddings --results-filename results/CAp_noembed_nochar_lstmnet.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --network-type lstm --embeddings /data/embeddings/wiki.en.bin --results-filename results/CAp_fasttext_lstmnet.csv
# python3 noise_experiment_CAp.py --dataset data/CAp/dataset_dict.pkl --original-testset data/CAp/test_set_wlabels.txt --network-type lstm --no-char-embeddings --embeddings /data/embeddings/wiki.en.bin --results-filename results/CAp_fasttext_nochar_lstmnet.csv

# echo -e "\W-NUT\n"
# python3 noise_experiment.py --dataset data/wnut --results-filename results/wnut_noembed.csv
# python3 noise_experiment.py --dataset data/wnut --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/wnut_fasttext.csv
# python3 noise_experiment.py --dataset data/wnut --no-char-embeddings --results-filename results/wnut_noembed_nochar.csv
# python3 noise_experiment.py --dataset data/wnut --no-char-embeddings --embeddings /media/data/nlp/data/wiki.en.bin --results-filename results/wnut_fasttext_nochar.csv
# python3 noise_experiment.py --dataset data/wnut --not-trainable-embeddings --results-filename results/wnut_noembed_not_trainable.csv
# python3 noise_experiment.py --dataset data/wnut --not-trainable-embeddings --no-char-embeddings --results-filename results/wnut_noembed_not_trainable_nochar.csv
# python3 noise_experiment.py --dataset data/wnut --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin --results-filename results/wnut_word2vec_fixed.csv
# python3 noise_experiment.py --dataset data/wnut --embeddings-format word2vec --embeddings /media/data/nlp/data/GoogleNews-vectors-negative300.bin  --no-char-embeddings --results-filename results/wnut_word2vec_fixed_nochar.csv
