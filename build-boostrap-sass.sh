#!/bin/bash
# This script creates a new subtheme for Bootstrap SASS theme. 
#
# Usage: 
# In your terminal: $ cd /your/site/drupal/sites/<whatever>/themes
# Clone repo
# Make sure script is executable : $ chmod +x build-bootstrap-sass.sh
# Run within directory: $ ./build-bootstrap-sass.sh
#

# build-bootstrap-sass run directory
BBS_DIR=`pwd`

# Get custom name
echo -n "Enter a human-readable subtheme name: "
read -e HUMANNAME

MACHINENAME=`echo $HUMANNAME | tr '[:upper:]' '[:lower:]' | sed -e 's/[ -]/_/g' -e 's/[^a-z0-9_]//g'`
# SEDNAME=`echo $HUMANNAME | sed -e 's/"/\\"/g'`

# Go to main themes/ directory
cd ..

# Copy sub-theme
echo 'Coping bootstrap sub-theme..'
cp -r bootstrap/bootstrap_subtheme $MACHINENAME

# Set .info file
cd $MACHINENAME
echo "Creating $MACHINENAME.info file.."
rm bootstrap_subtheme.info.starterkit 
cp $BBS_DIR/basic.info $MACHINENAME.info
# mv bootstrap_subtheme.info.starterkit $MACHINENAME.info

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
echo "Downloading bootstrap-sass $BOOTSTRAP_SASS_LATEST_VERSION.tar.gz package.."
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
  echo " > Coping $UNPACK_DIR_NAME/assets/$DIR .."
  cp -R $UNPACK_DIR_NAME/assets/$DIR bootstrap/
done

# Copy base .scss files
echo "Coping basic .scss files.."
cp -v bootstrap/stylesheets/_bootstrap.scss bootstrap/stylesheets/bootstrap/_variables.scss assets/sass/

echo "Create main style.scss SASS file.. "
mv -v assets/sass/_bootstrap.scss assets/sass/style.scss

echo "Replace 1 assets/sass/style.scss .."
sed -i.bak "s:bootstrap/:../../bootstrap/stylesheets/bootstrap/:g" assets/sass/style.scss

echo "Replace 2 assets/sass/style.scss .."
sed -i.bak 's&@import "../../bootstrap/stylesheets/bootstrap/variables";&@import "variables";&g' assets/sass/style.scss

# Prepare grunt package file
echo "Prepare grunt package file.."
cp $BBS_DIR/grunt.package.json package.json
sed -i.bak "s/#NAME#/$HUMANNAME/g" package.json

# Prepapre config.rb for COMPASS
echo "Prepapre config.rb for COMPASS.."
cp $BBS_DIR/compass.config.rb config.rb
sed -i.bak "s/#NAME#/$MACHINENAME/g" config.rb

# Prepare gruntfile.JS
echo "Prepare gruntfile.JS .."
cp $BBS_DIR/gruntfile.js gruntfile.js

# Removing temp files
echo "Cleaning (Delete temp files).."
rm -rf $UNPACK_DIR_NAME $TARGZ_NAME


# THE END
echo
echo -------------------------------------
echo Bootstrap sub-theme "$HUMANNAME" created..
echo
exit 0
