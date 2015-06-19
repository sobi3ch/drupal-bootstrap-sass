#!/bin/bash
# This script creates a new subtheme for Bootstrap theme. Place this file in 
# your sites/<whatever>/themes directory.
#
# Usage: 
# In your terminal: $ cd /your/site/drupal/sites/<whatever>/themes
# Make sure script is executable : $ chmod +x build-bootstrap-sass.sh
# Run it: $ ./build-bootstrap-sass.sh
#

# Current build-bootstrap-sass directory
BBS_DIR=`pwd`

# Get custom name
echo -n "Enter a human-readable subtheme name: "
read -e INPUTNAME

NAME=`echo $INPUTNAME | tr '[:upper:]' '[:lower:]' | sed -e 's/[ -]/_/g' -e 's/[^a-z0-9_]//g'`
SEDNAME=`echo $INPUTNAME | sed -e 's/"/\\"/g'`

# Go to main themes/ directory
cd ..

# Copy sub-theme
echo 'Coping bootstrap sub-theme..'
cp -r bootstrap/bootstrap_subtheme $NAME

# Set .info file
cd $NAME
echo "Creating $NAME.info file.."
mv bootstrap_subtheme.info.starterkit $NAME.info

# Create necessary dirs
echo "Creating necessary directories.."
mkdir -p \
  bootstrap \
  js \
  img \
  assets \
  assets/images \
  assets/js \
  assets/sass
  
  
# Get latest bootstarp-sass oficial code
echo "Getting latest bootstrap-sass version.."
BOOTSTRAP_SASS_LATEST_VERSION=$($BBS_DIR/get-tag.awk https://github.com/twbs/bootstrap-sass)

# Build url for bootstrap-sass lastest srouce code
BOOTSTRAP_SASS_URL=https://github.com/twbs/bootstrap-sass/archive/$BOOTSTRAP_SASS_LATEST_VERSION.tar.gz

# Download bootstrap-sass source code
wget $BOOTSTRAP_SASS_URL

# Unpacking
TARGZ_NAME=$BOOTSTRAP_SASS_LATEST_VERSION.tar.gz
echo "Unpacking $TARGZ_NAME .."
tar xzf $TARGZ_NAME

# Coping necessary assets
UNPACK_DIR_NAME=$(echo $BOOTSTRAP_SASS_LATEST_VERSION | sed 's/v/bootstrap-sass-/')
echo "Coping $UNPACK_DIR_NAME/assets.."
for DIR in `ls $UNPACK_DIR_NAME/assets`
do
  cp -vR $UNPACK_DIR_NAME/assets/$DIR bootstrap/
done

# Removing temp files
echo "Deleting temp files.."
rm -rf $UNPACK_DIR_NAME $TARGZ_NAME

# Copy base .scss files
echo "Coping basic .scss files.."
cp -v bootstrap/stylesheets/_bootstrap.scss bootstrap/stylesheets/bootstrap/_variables.scss assets/sass/

# asdf
mv assets/sass/_bootstrap.scss assets/sass/style.scss

# Replace 1
sed -i.bak "s:bootstrap/:../../bootstrap/stylesheets/bootstrap/:g" assets/sass/style.scss

# Replace 2
sed -i.bak 's&@import "../../bootstrap/stylesheets/bootstrap/variables";&@import "variables";&g' assets/sass/style.scss




















# THE END
echo Bootstrap sub-theme [$NAME] created..
exit 0
