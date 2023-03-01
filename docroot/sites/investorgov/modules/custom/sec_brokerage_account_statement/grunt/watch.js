//Documentation https://github.com/gruntjs/grunt-contrib-watch

module.exports = {

    js: {
      files: ['js/libraries/*.js','js/src/*.js'],
      tasks: ['uglify:build']
    },
    css: {
      options: {
        spawn: true
      },
      files: ['sass/**/*.scss'],
      tasks: /*'sass:build'*/['sass:build', 'postcss:build']
    },
    images: {
      files: ['images/src/**/*.jpg', 'images/src/**/*.png'],
      tasks: 'imagemin:build'
    }
};