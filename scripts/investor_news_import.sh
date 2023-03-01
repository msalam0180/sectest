#!/bin/sh
/usr/local/drush8/drush --uri=https://www.investor.gov @secgov.prod migrate-reset-status investor_alerts
/usr/local/drush8/drush --uri=https://www.investor.gov @secgov.prod migrate-import investor_alerts
