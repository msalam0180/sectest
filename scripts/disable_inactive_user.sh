#!/bin/bash

# Expire user account if user has been active for more then 30 days
/usr/local/drush10/drush @secgov.prod --uri=sec.gov eval 'disable_inactive_user(30);';
/usr/local/drush10/drush @secgov.prod --uri=investor.gov eval 'disable_inactive_user(30);';

# Send email notification if user account will expire within 5 days.
/usr/local/drush10/drush @secgov.prod --uri=sec.gov eval 'notify_inactive_user(25, 5);';
/usr/local/drush10/drush @secgov.prod --uri=investor.gov eval 'notify_inactive_user(25, 5);'
