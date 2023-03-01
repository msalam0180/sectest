//Documentation: github.com/anselmh/grunt-phantomcss

module.exports = {

  build: {
    options: {
      screenshots: 'testing/visual-regression/screenshots/',
      results: 'testing/visual-regression/results',
      viewportSize: [1280, 800],
      mismatchTolerance: 0.05//,
      //rootUrl: 'http://braver:9046/' // Optional
    },
    src: [
      'testing/visual-regression/js/**/*.js'
    ]
  }


};