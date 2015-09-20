# Drupal Bootstrap SASS

Using SASS in [Drupal Bootstrap theme](https://www.drupal.org/project/bootstrap). Based on blog *[Using SASS in Bootstrap Drupal theme](http://www.webfoobar.com/node/9)*. Without last section **Imagemin**.

Purpose of this script is to repeat all step in above blog to create drupal theme based on bootstrap theme with all changes necessary to work with SASS/Compass and Grunt.

Tested on Ubuntu 14.04. 

## Installation

### Requirements

Before you start make sure you have necessary tools.
```
$ sudo apt-get install -y build-essential wget ruby ruby-dev nodejs npm
```

Also you should have `awk` and `sed` alredy installed. Check with
```
$ type awk sed
```

Install [Grunt](http://gruntjs.com/) globally
```
$ sudo npm install -g grunt-cli
```

Install [Compass](http://compass-style.org/)
```
$ sudo gem install --no-ri --no-rdoc compass
```

### Installation

* Prepare your Drupal page as always if you didn't done this already
* Download and unpack [Bootstrap](https://www.drupal.org/project/bootstrap) theme (`drush dl -y bootstrap`)
* Clone this repo inside your main `themes/` directory (`<drupaldir>/sites/all/themes`)
    * `$ git clone git@github.com:sobi3ch/drupal-bootstrap-sass.git`
* `cd` to it
* Make sure scripts are executable: `$ chmod +x build-boostrap-sass.sh get-tag.awk`
* Run `./build-boostrap-sass.sh`
* Pass your human readable sub-theme name
* **Wait until build finish..**
* Then `cd ../YOUR_THEME` and run `npm install`, this will install grunt dependencies
* Finally enable your custom sub-theme eather via UI or drush (`drush en -y YOUR_THEME`)
* Congratulations!

### Usage

* Inside your theme run `$ grunt`. This will start watching your Sass files. 
* Start editing `sites/all/themes/<YOUR_THEME>/assets/sass/style.scss`. Put your custom sass on the end of the file. On save all styles will be rebuilded automatically. Reload your page, you should see changes.

Rest of tasks can be seen via `$ grunt -h`. Check [blog](http://www.webfoobar.com/node/9) for more details.

Comments/suggestions welcome.

