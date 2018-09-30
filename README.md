![Zipsell intro](https://www.zipsell.org/images/PH/Poster1.png)

# Zipsell

Zipsell helps you set up an online store for selling digital products such as ebooks, music, videos, source code etc. 

Zipsell handles payment processing via stripe and sends customers secure expiring Amazon S3 links to the files they have purchased. Since it is self-hosted, you receive payments directly and avoid paying commissions to 3rd party marketplaces.

Zipsell is built with Ruby on Rails.

Demo site - http://demo.zipsell.org

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Zipsell is a Ruby on Rails app. These instructions assume you have run a rails app on your local machine before.

### Installing

Clone the project into a local folder and run the included setup file:

```
git clone https://github.com/yongfook/zipsell
cd zipsell
./bin/setup
```

### Configuration

During local setup above, a git-ignored config file is generated at `config/application.yml`.

Populate this with your local and production config for Amazon AWS, Stripe etc. You can have environment-specific values for local, test and production. `ENV` config is handled by the [Figaro](https://github.com/laserlemon/figaro) gem.

The config template looks like this:

```
#general - all required
shop_name: My Shop
shop_domain: localhost:3000
shop_email_support: test@localhost.com
shop_email_noreply: noreply@localhost.com

#email - all required, for email delivery in production
SMTP_host: 
SMTP_port: 
SMTP_username: 
SMTP_password: 

#payments - all required, for processing payments
stripe_api_key: 
stripe_publishable_key: 

#file storage - all required, for storing files securely
AWS_REGION: 
AWS_BUCKET: 
AWS_ACCESS_KEY_ID: 
AWS_SECRET_ACCESS_KEY: 

#file management - all required
file_expiry_hours: "24"
file_max_downloads: "10"

#cdn host - optional, for faster static asset serving in production
cdn_host_assets: 
cdn_host_s3_bucket: 

#analytics - optional, in the format UA-XXXXXXXX-XX
google_analytics_id:

#
# production:
#   stripe_api_key: 
#   stripe_publishable_key: 
```

These should be self explanatory except for the optional `cdn host` section.

**cdn_host_assets:** This is the optional Rails asset pipeline cdn host. Use this if you want to serve css / js faster. Include the protocol you want to use e.g. `https://myapp.cdn.com`

**cdn_host_s3_bucket:** This is the optional Amazon Cloudfront cdn host for your S3 bucket. Use this if you want to serve uploaded image files faster. Do not include the protocol, use only the hostname e.g. `randomname.cloudfront.net`

### Running locally

Start your rails server:

```rails s```

Your shopfront is at:

```http://0.0.0.0:3000```

Your admin dashboard is at:

```http://0.0.0.0:3000/admin```

## Deployment on Heroku

To deploy to heroku for the first time:

```
heroku create
git push heroku master
heroku run rails db:migrate
figaro heroku:set -e production
```

The last line updates the remote heroku server with the `ENV` config in `config/application.yml`. 

You will need to run this command again if you change your production config.

## Contributing

In general, we follow the "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## Built With

- [Amazon S3](https://aws.amazon.com/s3/) is used as the file store. All downloadable files have non-public access rights and download links are securely signed with a configurable expiry time.
- [Bulma](https://bulma.io) is used as the css framework.
- [Figaro](https://github.com/laserlemon/figaro) is used to set production configuration without commiting files or storing sensitive information in databases.
- [Heroku](https://heroku.com) is used as the production environment in my readme, although you are free to deploy it anywhere else.
- [Paperclip](https://github.com/thoughtbot/paperclip) is used for file attachments. I purposely removed Active Storage from the app as it is currently not suitable for serving files via CDN. Zipsell needs flexibility - image previews can be served from a CDN while private, downloadable files are served directly from the S3 bucket.
- [Ruby on Rails](https://rubyonrails.org) is used as the web application framework.
- [Stripe](https://stripe.com/) is used as the payment processor. You use your own Stripe account with Zipsell and all payments go directly to you.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
