requirejs.config({
  baseUrl: './',
  paths: {
    jquery: 'lib/jquery/jquery-3.2.1.min',
    webcast: '../docroot/modules/custom/sec_webcast/js/webcast'
    // webcastTest: '../modules/custom/sec_webcast/js/tests/webcast-test'
  },
  shim: {
    webcastTest: {
      deps: ['jquery']
    }
  }
});

// Load the main app module to start the app
requirejs(['./src/app']);
