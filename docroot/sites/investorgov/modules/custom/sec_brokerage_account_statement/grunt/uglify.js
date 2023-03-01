//Documentation https://github.com/gruntjs/grunt-contrib-uglify

module.exports = {
  build: {
    src: ['js/libraries/*.js','js/src/*.js'],
    dest: 'js/build/brokerage_scripts.min.js',
    options: {
      sourceMap: true,
      sourceMapIncludeSources: true,
      banner: '/*! <%= grunt.template.today("yyyy-mm-dd") %> */\n'
    }
  },
  prod: {
    src: ['js/libraries/*.js','js/src/*.js'],
    dest: 'js/build/brokerage_scripts.min.js',
    options: {
      sourceMap: false
    }
  }

};