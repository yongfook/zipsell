# Zipsell

Zipsell helps you set up an online store for selling digital products such as ebooks, music, videos, source code etc. 

Zipsell handles payment processing via stripe and sends customers secure expiring Amazon S3 links to the files they have purchased. Since it is self-hosted, you receive payments directly and can avoid paying commissions or fees to 3rd party marketplaces.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Zipsell is a Ruby on Rails app. These instructions assume you have run a rails app on your local machine before.

### Installing

Clone the project into a local folder and run the included setup file. Then simply start your rails server.

```
git clone https://github.com/yongfook/zipsell
cd zipsell
./bin/setup
rails s
```

## Deployment on Heroku

Zipsell uses the [Figaro](https://github.com/laserlemon/figaro) gem to configure `ENV`.

During local setup above, a git-ignored config file is generated at `config/application.yml`.

Populate this with your production config for Amazon AWS, Stripe etc. You can have environment-specific values for local, test and production - read the Figaro docs for more detail.

To deploy to heroku for the first time:

```
heroku create
git push heroku master
heroku run rails db:migrate
figaro heroku:set -e production
```

## Built With

* [Ruby on Rails](https://rubyonrails.org) - The web application framework used
* [Bulma](https://bulma.io) - The CSS framework used

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details