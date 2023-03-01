//Documentation https://github.com/Ensighten/grunt-spritesmith

module.exports = {
   build: {
    // Include all normal and `-2x` (retina) images
    //   e.g. `github.png`, `github-2x.png`
    src: ['images/sprite-images/*.png'],

    // Filter out `-2x` (retina) images to separate spritesheet
    //   e.g. `github-2x.png`, `twitter-2x.png`
    retinaSrcFilter: ['images/sprite-images/*-2x.png'],

    // Generate a normal and a `-2x` (retina) spritesheet
    dest: 'images/spritesheet.png',
    retinaDest: 'images/spritesheet-2x.png',

    // Generate SCSS variables/mixins for both spritesheets
    destCss: 'sass/_sprites.scss',

  }

};