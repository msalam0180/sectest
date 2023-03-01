define([
  'jquery'
], function ($) {
  //  All test will we executed from this level;
  var SpeakerJSONtest =  function () {
    QUnit.module('speakers.json test');
    var xhr = $.ajax({
      url: 'https://www.sec.gov/speakers.json?search=s&term=s',
      type: 'GET',
      dataType: 'json',
      success: function (data, textStatus, xhr) {

        QUnit.test('Request to speakers json returns 200', function (assert) {
          assert.equal(xhr.status, 200);
        });

        QUnit.test('Speakers json is not returning empty value', function (assert) {
          assert.notEqual(data, {});
        });
      }
    });
  };
  SpeakerJSONtest();
});
