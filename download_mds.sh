# based on: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md

# make index not needed  # put where

mdkdir -p $HOME/mds
export MDS_DATA_PATH=$HOME/data/mds

export RECORDS=$MDS_DATA_PATH/records
export SPLITS=$MDS_DATA_PATH/splits

# -- ilsvrc_2012: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#ilsvrc_2012
# - 1. Download ilsvrc2012_img_train.tar, from the ILSVRC2012 website
# todo: https://gist.github.com/bonlime/4e0d236cf98cd5b15d977dfa03a63643
# todo: https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md#ilsvrc_2012
# wget TODO -O $MDS_DATA_PATH/ilsvrc_2012
# for imagenet url: https://image-net.org/download-images.php
wget https://image-net.org/data/winter21_whole.tar.gz -O ~/data/winter21_whole.tar.gz

# - 2. Extract it into ILSVRC2012_img_train/, which should contain 1000 files, named n????????.tar (expected time: ~30 minutes)
# tar https://superuser.com/questions/348205/how-do-i-unzip-a-tar-gz-archive-to-a-specific-destination
tar xf ~/data/winter21_whole.tar.gz -C ~/data/winter21_whole
# move the train part: mv src dest
mv ~/data/winter21_whole/ILSVRC2012_img_train $MDS_DATA_PATH/ILSVRC2012_img_train

# - 3. Extract each of ILSVRC2012_img_train/n????????.tar in its own directory (expected time: ~30 minutes), for instance:
for FILE in $MDS_DATA_PATH/ILSVRC2012_img_train/*.tar;
do
  echo $FILE
#  mkdir ${FILE/.tar/};
#  cd ${FILE/.tar/};
#  tar xvf ../$FILE;
#  cd ..;
done

# - 4. Download the following two files into ILSVRC2012_img_train/
wget http://www.image-net.org/data/wordnet.is_a.txt -O $MDS_DATA_PATH/ILSVRC2012_img_train/wordnet.is_a.txt
wget http://www.image-net.org/data/words.txt -O $MDS_DATA_PATH/ILSVRC2012_img_train/words.txt

# - 5. Launch the conversion script (Use --dataset=ilsvrc_2012_v2 for the training only MetaDataset-v2 version):
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=ilsvrc_2012 \
  --ilsvrc_2012_data_root=$DATASRC/ILSVRC2012_img_train \
  --splits_root=$SPLITS \
  --records_root=$RECORDS

# -6. Expect the conversion to take 4 to 12 hours, depending on the filesystem's latency and bandwidth.
#nop

# - 7.Find the following outputs in $RECORDS/ilsvrc_2012/:
      #
      #1000 tfrecords files named [0-999].tfrecords
      #dataset_spec.json (see note 1)
      #num_leaf_images.json
ls $RECORDS/ilsvrc_2012/

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
