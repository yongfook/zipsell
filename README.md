# Local setup

```
git clone https://github.com/yongfook/zipsell
cd zipsell
./bin/setup
rails s
```

# Deploying to Heroku

Zipsell uses the [Figaro](https://github.com/laserlemon/figaro) gem to configure `ENV`.

During local setup above, a git-ignored config file is generated at `config/application.yml`.

Populate this with your production config for Amazon AWS, Stripe etc. You can have environment-specific values for local, test and production - read the Figaro docs for more detail.

After deploying to Heroku for the first time, run:

```
figaro heroku:set -e production
```