//Documentation https://github.com/nDmitry/grunt-postcss

module.exports = {

    build: {
      src: 'css/styles.css',

      options: {
        map: {
          inline: true,
          sourcesContent: true
        },
        processors: [
          require('autoprefixer')({
            browsers: ['last 3 versions', 'ie 8', 'ie 9']
          })
        ]
      }

    },

  prod: {
    src: 'css/styles.css',

    options: {
      map: false,
      processors: [
        require('autoprefixer')({
          browsers: ['last 3 versions', 'ie 8', 'ie 9']
        })
      ]
    }

  }




};