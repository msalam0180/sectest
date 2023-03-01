//Documentation https://github.com/gruntjs/grunt-contrib-jshint

module.exports = {
      options: {
        reporter: require('jshint-stylish')
      },
      all: ['js/src/**/*.js']
}