
Login Security
--------------
This module was developed to improve the security options in the login operation
of a Drupal site. By default, Drupal has only basic access control denying IP
access to the full content of the site.

With Login Security module, a site administrator may add any of the following
access control features to the login forms (default login form in /user and the
login form block).

These are the features included:

Ongoing attack detection
------------------------
System will detect if a password guessing or brute-force attack is being
performed against the Drupal login form. Using a threshold value, you may
instruct the module to alert (using a watchdog message, and optionally sending
an email) the admin user when the number of invalid login attempts reaches the
threshold value.

Soft protections
----------------
Soft protections don't disrupt site navigation, but alter the way a login
operation is performed.

Currently, the login form submission can be soft-protected with these two
options:

 - Invalidate login form submission: when the soft-block protection flag is
   enabled, the login form is never submitted and any new login request will
   fail, but the host can still access the site.


Hard protections
----------------
When there is evidence of hard account guessing operations or when you need to
block users because of leak password guessing attempts, hard protections may
prevent the system being beaten.

 - Block account: it's common to block an account after a number of failed login
   attempts. Once this number is reached, the account can be blocked and the
   user and admin are advised.

 - Block IP address: on a number of failed attempts, a host may be added to the
   access control list. This action will leave the host completely banned from
   the site.


Track time: protection time window
----------------------------------
The time the protections are defined as a time window (or "track time"), the
time during which login events are being considered for protective action.
For example, an account can be blocked on the third login attempt in the
protection time window. If the time protection window is one hour, the three
attempts must be within the last 60 minutes.

Blocked accounts and hosts will remain blocked until an administrator unblocks
them.


Duration of protections
-----------------------
The duration of the enabled protections depends on its type. Soft protections
are temporary and will expire after the time defined by the "track time" or
protection time window.

Hard protections are permanent and require an administrator to unblock or unban
an account or host.

A blocked account can be unblocked through the administration section:
  /admin/user/user
A banned host can be unbanned through the Access rules section:
  /admin/user/rules


Installation
------------
To install, copy the login_security folder in your modules directory. Go to
Administer -> Site Building -> Modules and, under the "Other" frame, the
"Login Security" module item will appear in the list. Enable the checkbox
and save the configuration.


Configuration options
---------------------
You should have the "administer site configuration" permission to configure the
Login Security module.

Go to Administer -> Site configuration -> Login Security (the URL path is
admin/settings/login_security) and a form with the module options will be shown.
Note: any value set to 0 will disable that option.

Basic options

 - Track time: the time window in which to check for security violations. It's
   the time in hours for which the login information is kept to compute the
   login attempts count (e.g. 24 hours). After that time, the attempt is
   deleted from the list and will not count.

 - Maximum number of login failures before blocking a user: after this number of
   attempts to login as a user (regardless of the IP address used), the user
   will be blocked. To remove the block of the user, go to:
   Administer -> User Management -> Users

 - Maximum number of login failures before soft blocking a host: after this
   number of attempts to login from that IP address (regardless of the
   username), the host will not be allowed to submit the login form again, but
   the content of the site will still be accessible from that IP address. The
   login attempts tracked will start to clear after the "track time" time
   window.

 - Maximum number of login failures before blocking a host: analogous to soft
   blocking, but the IP address will be completely banned from the site, using
   the access list as a deny rule. To remove the IP from this ban, go to:
   Administer -> User Management -> Access Rules

 - Maximum number of login failures to detect ongoing attack: the threshold used
   to detect a password guess attack. The limit means that, during the "track
   time" period, this number of invalid login attempts indicates a password
   guessing attack.

Notifications

 This module also provides notifications to notify users of relevant activity.

 - Display last login timestamp: each time a user logs in successfully, this
   message will remind him of the last time he logged into the site.

 - Display last access timestamp: each time a user logs in successfully, this
   message will remind him of the last time he accessed the site.

 - Notify the user about the number of remaining login attempts: advise the user
   of attempts prior to the account being blocked.

 - Disable login failure error message: No error message will be shown at all so
   the user will not be made aware of unsuccessful login attempts or blocked
   account messages.

 - Send a notification email to a site user of your choice each time an account
   is blocked.

 - Send a notification email to a site user of your choice about suspicious
   login activity (once a specified threshold of invalid login attempts is
   reached).

Notifications are configurable in the Login Security settings section. The
strings can be personalized using the following placeholders:

    %date                  :  The (formatted) date and time of the operation
    %ip                    :  The IP Address performing the operation
    %username              :  The username entered in the login form (sanitized)
    %email                 :  If the user exists, this will be it's name
    %uid                   :  ...and if exists, this will be it's uid
    %site                  :  The configured site's name
    %uri                   :  The base url of the Drupal site
    %edit_uri              :  Direct link to the user (name entered) edit page
    %hard_block_attempts   :  Configured attempts before hard blocking the IP
    %soft_block_attempts   :  Configured attempts before soft blocking the IP
    %user_block_attempts   :  Configured login attempts before blocking the user
    %user_ip_current_count :  The total attempts for the name by this IP address
    %ip_current_count      :  The total login attempts by this IP address
    %user_current_count    :  The total login attempts for this name
    %tracking_time         :  The tracking time (in hours)
    %tracking_current_count:  Total tracked events
    %activity_threshold    :  Value of attempts to detect ongoing attack


Cleaning the event tracking information
---------------------------------------
If for any reason you are encountering problems with specific users (because
they are restricted), or if you change settings and want to do a module
"restart", you can delete the event tracking information using the "Clear event
tracking information" button on the settings page.


Understanding protections
-------------------------
Internally, protections could consider username, IP address, or both. This is a
list of what's now implemented and how login submissions affect the protections:

 1. On any login, the pair host<->username is saved for security, and only on a
    successful login or by track time expiration, the pair host-username is
    deleted from the security log.

 2. For the soft blocking operation, any failed attempt from that host is
    tracked and, when the number of attempts is exceeded, the host is not
    allowed to submit the form.

    Note: (2nd and 3rd impose restrictions to the login form and the time these
    restrictions are in rule is the time the information is being tracked:
    "Track Time").

 3. For the user blocking operation, any failed attempt is tracked so, no matter
    what the source IP address is, when too many attempts appear, the account is
    blocked. A successful login, even if the user is blocked, will remove any
    entries from the database.

 4. For the host blocking operation, only the host is taken into account. When
    too many attempts are made, regardless of the username being tested, the
    host IP address is banned.

    Note: 4th and 5th operations are not cancelled automatically.
    Note: The tracking entries in the database for any host <-> username pair
          are deleted on: "login", "update", and "delete" user operations.

 5. For the ongoing attack detection, all the tracked events are taken into
    account. The system detects an ongoing attack and notifies the admin.
    It will remain inattack mode (no more notices will be sent) until the
    attack is no longer detected. This will happen when the total number of
    tracked events is below "maximum allowed to detect ongoing attack" / 3.
    Once the threshold is reached again, a new notification will be logged or
    sent by email.

    E.g. Say you put 1 hour of track time and a maximum number of login failures
    to detect an ongoing attack of 20. This means that, if during the last hour
    there are more than 20 invalid login attempts, an attack is detected. A log
    entry is created and the system switches to "attack" mode, in which no more
    notices about the attack are logged or sent. After some time, the attack]
    stops. Once the number of invalid login attempts for this last hour
    is below 1/3 of this maximum: invalid attempts are below 6 (20 / 3 in this
    example), the system returns to normal status. If a new attack is detected,
    the module will alert about it again.


Most used configuration
-----------------------
The most common configuration options will look like this:

 Track time = 1 Hour
 Max number of login failures before blocking a user  = 5
 Max number of login failures before soft blocking a host  = 10
 Max number of login failures before blocking a host  = 15

 - The user will be blocked after five account guesses within the "track time".
 - Any host attempting 10 logins will be punished by not being permitted to
   submit the login form again within the "track time".
 - If the number of attempts reaches 15, the host will be banned.


Interaction with other modules
-------------------------
If you want your users to be informed when their accounts have been blocked,
you can use the module "Extended user status notifications":
http://www.drupal.org/project/user_status


Important note
--------------

Currently, user uid 1 is never blocked, even if the "user blocking operation" is
enabled. User uid 1 is widely exposed on too many sites (and probably the name
for that account is "admin") so uid 1 was is not provided this protection due to
the risk of being too easily blocked. If you want to protect your users, you can
use a combination of features, not relying solely on the user blocking
operation.

More information: http://drupal.org/node/601846


Other notes
-----------
The session ID (PHP session neither Drupal's session) is not taking in count for
the security operations, as automated brute-force tool may request new sessions
on any attempt, ignoring the session fixation from the server.


Thanks to...
-----------
Christefano and deekayen, both have done great contributions and help with this
module.
