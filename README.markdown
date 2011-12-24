craigs_admin
============

This is a DRY, well documented (inline) Rails (3.1) project which is suited as a basis to rapidly developing business application software.  In laymen terms, it is a simple front end website with some common pages like 'contact' and 'about us'.  But it has a powerful admin tool and an very clean REST/JSON API.

Out of the box, it has:

* Users
* Registration, Login, password reset etc. (through Devise)
    * Welcome email
    * Admin flag for users
    * Twitter and Facebook connect
* Admin
    * Searching, sorting and pagination of models
    * Very DRY approach to templates
* Website
    * Contact form
    * Team (about us) page which is populated from the Admin
* API
    * Helpers to normalize JSON output
    * Documentation for your API generated from a YAML file
* Other
    * Configuration options are ENV variables, not stored in code (meaning its safe to have multiple developers working on your project)
    * Well documented.  The code is sane and clean, lots of inline documentation.
    * Sassy, HAML and Formtastic
    * Care has been taken to do everything the 'Rails Way'
    * MySQL (foreign key constraints through foreigner) for business data, and MongoDB for non critical information such as user access logs.
    * Tested thoroughly to work out of the box with Heroku in-front of an Amazon RDS, MongoLab and SendGrid.

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

    rvm default
    
    # The name of this business, as displayed to your users throughout the application
    export BUSINESS_NAME="Your Business"
    # the from address used when sending email to customers, and also the email address we send admin emali to (e.g. from the conact form)
    export BUSINESS_EMAIL=support@yourdomain.com
    
    # used for facebook connect, google analytics, emails and other places where a master domain name is used to represent the business
    export BASE_DOMAIN_NAME=yourdomain.com
    
    # the database namespace used in database.yml, "foobar" will create foobar_development and foobar_test databases for MySQL and MongoDB
    export DATABASE_NAMESPACE=craigs_admin
    # mysql usernme and password
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD=
    
    # emails sent in development are intercepted and delivered to the developer, so we dont bombard customers by accident
    export DEVELOPER_EMAIL=you@yourdomain.com
    
    # we use AWS as a backend for fog and paperclip
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    
    # for onmiauth with facebook and facebook connect/widgets etc
    export FACEBOOK_CLIENT_ID=
    export FACEBOOK_SECRET=
    # for displaying to your customers
    export FACEBOOK_FAN_PAGE_NAME= 
    export FACEBOOK_FAN_PAGE_ID= 
    
    # for omniauth with twitter
    export TWITTER_CONSUMER_KEY=
    export TWITTER_CONSUMER_SECRET=
    # for displaying to your customers
    export TWITTER_SCREEN_NAME=
    
    # urchin code for google analytics
    export GOOGLE_ANALYTICS_ACCOUNT_ID=123456789-1
    
    # emails generated in development will be delivered through gmail 
    export GMAIL_DOMAIN=gmail.com
    export GMAIL_USER_NAME=you@gmail.com
    export GMAIL_PASSWORD=your_password



