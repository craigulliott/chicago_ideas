craigs_admin
============

This is a DRY, well documented (inline) Rails (3.1) project which is suited as a basis to rapidly developing business application software.  In laymen terms, it is a simple front end website with some common pages like 'contact' and 'about us'.  But it has a powerful admin tool and an very clean REST/JSON API.

Out of the box, it has:

* Users
** Registration, Login, password reset etc. (through Devise)
** Welcome email
** Admin flag for users
** Twitter and Facebook connect
* Admin
** Searching, sorting and pagination of models
** Very DRY approach to templates
* Website
** Contact form
** Team (about us) page which is populated from the Admin
* API
** Helpers to normalize JSON output
** Documentation for your API generated from a YAML file
* Other
** Configuration options are ENV variables, not stored in code (meaning its safe to have multiple developers working on your project)
** Well documented.  The code is sane and clean, lots of inline documentation.
** Sassy, HAML and Formtastic
** Care has been taken to do everything the 'Rails Way'
** MySQL (foreign key constraints through foreigner) for business data, and MongoDB for non critical information such as user access logs.
** Tested thoroughly to work out of the box with Heroku in-front of an Amazon RDS, MongoLab and SendGrid.

It was originally created (and is still used) as a basis for the SocialKaty platform (http://www.socialkaty.com) which is feature rich, used by 30 employees and handles in excess of 300K http transactions per day.  It is now also the basis of several other Chicago area startups, and is at the core of the ChicagoIdeasWeek (http://www.chicagoideas.com) platform.

Patches, comments and criticisms are extremely welcome.

Contributing to this project
----------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

Copyright
---------

Copyright (c) 2011 Craig Ulliott. See LICENSE.txt for
further details.

use this .rvmrc template when doing local development
-----------------------------------------------------

Please look in config/initializers/craigs_admin.rb for more details

    rvm default
    
    export BASE_DOMAIN_NAME=yourdomain.com
    export BUSINESS_NAME="Your Business"
    export BUSINESS_EMAIL=support@yourdomain.com
    
    export DEVELOPER_EMAIL=you@yourdomain.com
    
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    
    export FACEBOOK_CLIENT_ID=
    export FACEBOOK_SECRET=
    export FACEBOOK_FAN_PAGE_NAME= 
    export FACEBOOK_FAN_PAGE_ID= 
    
    export TWITTER_CONSUMER_KEY=
    export TWITTER_CONSUMER_SECRET=
    export TWITTER_SCREEN_NAME=
    
    export GOOGLE_ANALYTICS_ACCOUNT_ID=123456789-1
    export API_VERSION=1.0.0
    
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD=
    
    export GMAIL_DOMAIN=gmail.com
    export GMAIL_USER_NAME=you@gmail.com
    export GMAIL_PASSWORD=your_password



