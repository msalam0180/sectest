//Documentation https://github.com/ahmednuaman/grunt-scss-lint
//Lint Options (set in .scss-lint.yml file) https://github.com/brigade/scss-lint/blob/master/lib/scss_lint/linter/README.md


module.exports = {

  test: {
    allFiles: [
      'sass/**/*.scss'
    ],
    options: {
      bundleExec: true,
      config: '.scss-lint.yml',
      colorizeOutput: true,
      force: true,
      exclude: [
        'sass/_print.scss',
        'sass/base/_reset.scss',
        'sass/_sprites.scss',
        'node_modules/**/*.scss'
      ]
    }
  }
}