#!/bin/sh
cd ~/sec/secgov/test
export BEHAT_PARAMS='{"extensions": {"Behat\\MinkExtension": {"base_url": "http://drupal.jiratracker.com"},"Drupal\\DrupalExtension": {"drupal": {"drupal_root": "/home/gitlab-runner/sec/secgov/docroot"}}}}'
echo "Checking for behat installation"
if [ -e bin/behat ]
then
    echo "Behat found, re-running tests"
    bin/behat --rerun
else
    echo "Behat not found, you may need to run the behat job first"
fi