#!/bin/sh
#echo "Running PHPUnit Tests"
#cd docroot/core
#../../vendor/phpunit/phpunit/phpunit  --group sec

echo "Running PHP CodeSniffer on docroot/modules/custom/"
phpcs --standard=phpcs_ruleset.xml -s --warning-severity=0 docroot/modules/custom  

cd docroot/

echo "Running eslint on all custom module files."
eslint modules/custom/**/*.js

echo "Running eslint on all JS theme files."
eslint themes/custom/secgov/js/shared.js

