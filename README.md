#Local setup

```
git clone https://github.com/yongfook/zipcommerce
cd zipcommerce
./bin/setup
rails s
```

#Deploying to Heroku

Zipcommerce uses the [Figaro](https://github.com/laserlemon/figaro) gem to configure `ENV`.

During the local setup above, a git-ignored config file is generated at `config/application.yml`.

Populate this with your production config for Amazon AWS, Stripe etc. You can have environment-specific values for local, test and production - read the Figaro docs for more detail.

Before deploying to Heroku for the first time, run:

```
figaro heroku:set -e production
```

Then push to Heroku as you normally would:

```
git push heroku master
```