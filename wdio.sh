#!/bin/sh
cd ~/sec/secgov/test
export BEHAT_PARAMS='{"extensions": {"Behat\\MinkExtension": {"base_url": "http://drupal.jiratracker.com"},"Drupal\\DrupalExtension": {"drupal": {"drupal_root": "/home/gitlab-runner/sec/secgov/docroot"}}}}'
echo "Checking for behat installation"
if [ -e bin/behat ]
then
    echo "Behat found, running WDIO tests"
    bin/behat --suite=default --tags="ui"
else
    echo "Behat not found, running composer install"
    composer install
    echo "Running Behat tests with WDIO"
    bin/behat --suite=default --tags="ui"
fi
