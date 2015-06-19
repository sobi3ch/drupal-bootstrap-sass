module.exports = function (grunt) {
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.initConfig({
    uglify: {
      js_dev: {
        options: {
          preserveComments: 'all',
          beautify: {
            width: 80,
            beautify: true
          } // beautify
        }, // options
        files: {
          'js/scripts.js': [
            'bootstrap/javascripts/bootstrap/affix.js',
            'bootstrap/javascripts/bootstrap/alert.js',
            'bootstrap/javascripts/bootstrap/button.js',
            'bootstrap/javascripts/bootstrap/carousel.js',
            'bootstrap/javascripts/bootstrap/collapse.js',
            'bootstrap/javascripts/bootstrap/dropdown.js',
            'bootstrap/javascripts/bootstrap/modal.js',
            'bootstrap/javascripts/bootstrap/tooltip.js',
            'bootstrap/javascripts/bootstrap/popover.js',
            'bootstrap/javascripts/bootstrap/scrollspy.js',
            'bootstrap/javascripts/bootstrap/tab.js',
            'bootstrap/javascripts/bootstrap/transition.js',
            'assets/js/*.js'
          ]
        } // files
      }, // js_dev
      js_prod: {
        files: {
          'js/scripts.js': [
            'bootstrap/javascripts/bootstrap/affix.js',
            'bootstrap/javascripts/bootstrap/alert.js',
            'bootstrap/javascripts/bootstrap/button.js',
            'bootstrap/javascripts/bootstrap/carousel.js',
            'bootstrap/javascripts/bootstrap/collapse.js',
            'bootstrap/javascripts/bootstrap/dropdown.js',
            'bootstrap/javascripts/bootstrap/modal.js',
            'bootstrap/javascripts/bootstrap/tooltip.js',
            'bootstrap/javascripts/bootstrap/popover.js',
            'bootstrap/javascripts/bootstrap/scrollspy.js',
            'bootstrap/javascripts/bootstrap/tab.js',
            'bootstrap/javascripts/bootstrap/transition.js',
            'assets/js/*.js'
          ]
        } // files
      } // js_prod
    }, // uglify
    compass: {
      prod: {
        options: {
          config: 'config.rb',
          environment: 'production'
        } // options
      }, // prod
      dev: {
        options: {
          config: 'config.rb'
        } // options
      } // dev
    }, // compass
    watch: {
      sass: {
        files: [
          'assets/sass/*.scss'
        ],
        tasks: ['compass:dev']
      }, // sass
      javascripts: {
        files: ['assets/js/*.js'], // We only need to watch the custom js
        tasks: ['uglify:js_dev']
      } // javascripts
    } // watch
  }); // initConfig
  grunt.registerTask('default', 'watch');
  grunt.registerTask('prod', ['uglify:js_prod', 'compass:prod']);
} // exports
