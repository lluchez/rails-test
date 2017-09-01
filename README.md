This is a test project to test deployment on heroku and using apps/tools like CircleCI, Rollbar, CodeClimate, etc

Project is currently visible [here](https://lluchez-rails-test.herokuapp.com/). The following resource is also accessible: `[todos](https://lluchez-rails-test.herokuapp.com/todos)`.

# Steps

Below are the steps I followed to install of these tools/apps and creating the Rails webapp from scratch.
You can also use the following [link](https://relishapp.com/rspec/rspec-rails/docs/gettingstarted) to help you getting started.

## Installing Ruby and Rails
```
rvm install ruby-2.3.3
rvm use 2.3.3
sudo gem install rails
rails -v
```

## Creating the Rails App
Using MySQL:
```
rails new <app-name> -d mysql
```
with sqlite3 (default)
```
rails new <app-name>
```
If you need to switch to MySQL afterwards, run the following command:`gem install mysql2` and editing `config/database.yml` accordingly.


## Github
TO DO: To be documented...

## Heroku
### Create an heroku instance
```
heroku create
heroku rename <my-app-name>
git push heroku master
```
### Enable PostgreSQL on Heroku
Run the follow command to add the postgresql adon:
```
heroku addons:create heroku-postgresql:hobby-dev
```
This command will create the ENV variable `DATABASE_URL` containing the connection string
Update your `database.yml` file as per below (that's all you need):
```
production:
  encoding: utf8
  reconnect: false
  pool: 5
```

When going to `Settings` on your Heroku App page, next to `Domains and certificates` you will be able to see the URL of your app.
You can also add a `NodeJS` build step for instance (if you're using `Webpack`/`Yarn`).


## Unit Test (Rspec/FacoryGirl)
### Gemfile changes
Add the following code to your `Gemfile`:
```
group :test do
  gem 'capybara'
  gem 'codecov', :require => false
  # gem 'poltergeist'
  # gem 'ci_reporter'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  # gem "fakeredis"
  gem 'guard-rspec', require: false
  # gem 'launchy'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'simplecov', '0.7.1', :require => false
  gem 'webmock'
  gem 'rspec_junit_formatter', '0.2.2'
end
```

You might also need to run this command
```
generate rspec:install
```

### CircleCI (Automatic specs runner)
#### Create config file for CircleCI.
Create the following `circle.yml` file:
```
# https://circleci.com/docs/yarn/
machine:
  # environment:
  #   PATH: "${PATH}:${HOME}/${CIRCLE_PROJECT_REPONAME}/node_modules/.bin"
  # node:
  #   version: 6.9.1
  ruby:
    version: 2.3.3
  post:
    - mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u ubuntu mysql

dependencies:
  pre:
    - gem update --system
    - gem install bundler
  override:
    # - yarn
    # - npm rebuild node-sass
    - bundle check --path=vendor/bundle || bundle install --path=vendor/bundle --jobs=4 --retry=3
  # cache_directories:
  #   - ~/.cache/yarn

# compile:
#   post:
#     - yarn run build:prod
```

#### Creating the CircleCI project
- Go to `https://circleci.com/`
- Click on `Projects` (left panel)
- Click on `Add project` (top right corner)
- Click on `Setup project` on your project you want to monitor

#### New environment
*NOTE:* When using a v1.0 build (via `circle.yml`), CircleCI will automatically override the the `database.yml` config file with the correct values. As a consequence, defining a separate environment is not necessary.
~~I would also suggest to create a new enviconment `circle` so you can separate local specs vs CiricleCI specs.~~
~~For that you will need to:~~
- ~~Duplicate the file `config/environments/test.rb` as `config/environments/circle.rb`~~
- ~~Update your `datbase.yml` file to create a new section for `circle` with the following information:~~
```
circle:
  adapter: mysql2
  database: circle_test
  username: ubuntu
  password: ubuntu
  host: localhost
```
- ~~Finally go to your CircleCI project, click on the `Settings` wheel, click on `Environment Variables`, click on `Add Variable` to add `RAILS_ENV` with the value `circle`.~~

#### Github Webhook
For builds to be automatically triggered, you can go to `GitHub` and setup a Webhook:
- Go to the page of your Github project
- Click on `Settings`
- Click on `Webhooks` (left panel)
- Click on `Add webhook`
  - Payload URL: `https://circleci.com/hooks/github`
  - Secret: Visit [this page](https://developer.github.com/webhooks/securing/#setting-your-secret-token) for more information. I actually don't remember what I did here. #oups
  - Select `Let me select individual events` and select the relevant events. Basically everything, except: `Deployment`, `Deployment status`, `Label`, `Milestone`, `Page Build`, ``Project`, `Project card`, `Project column`, `Pull request review` and `Repository`). NOTE, actually this can probably be triggered on way less events.

## Rollbar
TO DO: To be installed...

## CodeClimate
TO DO: To be installed...


# Other resources
- https://github.com/bodyshopbidsdotcom/rubo-on-rails-template
- https://github.com/bodyshopbidsdotcom/snapsheet-tx/pull/376/files
