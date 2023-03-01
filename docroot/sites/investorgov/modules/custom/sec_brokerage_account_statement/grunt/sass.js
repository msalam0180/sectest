//Documentation https://github.com/gruntjs/grunt-contrib-sass

module.exports = {

  build: {

    options: {
      style: 'expanded',
      lineNumbers: true,
      bundleExec: true,
      sourcemap: 'file',
      require: [
        'breakpoint',
        'sass',
        'singularitygs'
      ]
    },

    files: {
      'css/brokerage_module.css': 'sass/styles.scss'
    }

  },
  prod: {

    options: {
      compass: true,
      style: 'compressed',
      lineNumbers: false,
      bundleExec: true,
      sourcemap: 'none',
      require: [
        'breakpoint',
        'compass',
        'sass',
        'singularitygs'
      ]
    },

    files: {
      'css/brokerage_module.css': 'sass/styles.scss'
    }

  }

};