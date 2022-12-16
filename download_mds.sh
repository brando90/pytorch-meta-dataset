# based on
#   https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md
# and https://github.com/brando90/pytorch-meta-dataset#12-data

mdkdir -p $HOME/mds
export MDS_DATA_PATH=$HOME/data/mds

# -- ilsvrc_2012: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#ilsvrc_2012
# - 1. Download ilsvrc2012_img_train.tar, from the ILSVRC2012 website
# todo: https://gist.github.com/bonlime/4e0d236cf98cd5b15d977dfa03a63643
# todo: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#ilsvrc_2012
# wget TODO -O $MDS_DATA_PATH/ilsvrc_2012


# -- omniglot: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#omniglot
# 1. download omniglot
wget https://github.com/brendenlake/omniglot/raw/master/python/images_background.zip -O $MDS_DATA_PATH/omniglot
wget https://github.com/brendenlake/omniglot/raw/master/python/images_evaluation.zip -O $MDS_DATA_PATH/omniglot

# what is
#   --splits_root=$SPLITS \
#   --records_root=$RECORD

python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=omniglot \
  --omniglot_data_root=$DATASRC/omniglot \
  --splits_root=$SPLITS \
  --records_root=$RECORDS

# -- aircraft: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#aircraft
# 1. download
wget http://www.robots.ox.ac.uk/~vgg/data/fgvc-aircraft/archives/fgvc-aircraft-2013b.tar.gz -O $MDS_DATA_PATH/aircraft
