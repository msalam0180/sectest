module.exports = function(grunt) {

  //Displays timing information for grunt tasks
  //require('time-grunt')(grunt);

  require('load-grunt-config')(grunt, {

    jitGrunt: {
      jitGrunt: true,
      staticMappings:{
        sprite: 'grunt-spritesmith',
        scsslint: 'grunt-scss-lint'
      }
    }

  });

  //grunt.loadNpmTasks('grunt-scss-lint');
};