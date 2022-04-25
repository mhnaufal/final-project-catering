# GenGIGIH Final Project | Catering 🦐

This repository is suppose to be the repo for my implementation of GenGIGIH final project

### Author

Muhammad Naufal Pratama
KM_G2BE4080

### Developement

#### Replit

Before click on the run button, do some of these steps:

1. Open up the Gemfile and make sure the Ruby version is 3.0.3

```ruby
ruby "3.0.3"
```

2. Go to the Replit console or shell
3. Type some of the following commands for preparing the database and seeds

```shell
rails db:migrate:redo
rails db:migrate:redo RAILS_ENV=test
```

```shell
bundle exec rake db:seed
```

4. Install rspec

```shell
bundle exec rspec
```

5. Run the test

```shell
bundle exec rspec -fd
```

6. RUN
   just click the green button above

#### Local

1. Clone
   sorry but I don't know how to clone directly from Replit
2. Install the packages

```shell
bundle install
```

3. Follow the Replit steps previously mentioned
4. Run

```ruby
rails s
```

### Useful Commands

#### Rails

```ruby
rails generate controller name
```

#### Sqlite3

See all tables

```sql
.tables
```

Describe a table

```sql
.mode markdown
pragma table_info('table name')
```

#### Etc

- **create** saved the instance into database while **build** only saved it on memory

- Use **create** in controllers because the controllers need to do a query into a database

- I use Ruby version 3.1.1 locally via Windows + VSCode, but in Replit the only available Ruby version is 3.0.3, so kindly check the Ruby version in the Gemfile and change it to 3.0.3 if needed 😁

- I also create an Insomnia API json file _(insomnia-api.json)_ for testing the endpoints, just import it to the [Insomnia software](https://insomnia.rest/) and you're ready to go

### Credits

Thanks to [Generasi GIGIH 2.0](https://www.anakbangsabisa.org/generasi-gigih/) for providing me with a such wonderful journey

Extra note = I use branch **develop** as the place where the history of commits exist
