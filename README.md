# Drupal Bootstrap SASS

Using SASS in [Drupal Bootstrap theme](https://www.drupal.org/project/bootstrap). Based on blog *[Using SASS in Bootstrap Drupal theme](http://www.webfoobar.com/node/9)*. Without last section **Imagemin**.

Purpose of this script is to repeat all step in above blog to create drupal theme based on bootstrap theme with all changes necessary to work with SASS/Compass.

Tested on Ubuntu 14.04. 

## Installation

### Requirements

Before you start make sure you have necessary tools.
```
$ sudo apt-get install -y ruby ruby-dev nodejs npm
```

Install [Grunt](http://gruntjs.com/) globally
```
$ sudo npm install -g grunt-cli
```

Install [Compass](http://compass-style.org/)
```
$ sudo gem install --no-ri --no-rdoc compass
```

### Installatioin

* Clone this repo inside your `<drupaldir>/sites/all/themes`.
* `cd` to it
* Make sure script is executable: `$ chmod +x build-boostrap-sass.sh`
* Run `./build-boostrap-sass.sh`
* Pass your human readable sub-theme name
* Wait when everything will build..
* Then `cd ../YOUR_THEME` and run `npm install`, this will install grunt dependencies
* sudo gem install --no-ri --no-rdoc compass

### Usage

Inside your theme run `$ grunt`. Rest of tasks can be seen via `$ grunt -h`. Check [blog](http://www.webfoobar.com/node/9) for details.
