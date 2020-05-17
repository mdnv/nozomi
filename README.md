# Source information
* Ruby version:   2.6.5
* Rails:          6.2.0.1
* Developer:      2nf Ruby on Rails Development Team

# Features in future
- Capistrano for deployment
- Docker
- CI/CD
- Unit test
...

# How to build source code
1. **Install environment**
https://gorails.com/setup
2. **Config applications**
- Copy, rename file: `.env.example` to be `.env` and change configs.
- Copy, rename file: `.env.#{your_environment}.example` to be `.env.#{your_environment}` and change configs.

*Notice:*

- `RAILS_WEB_CONCURRENCY` is the number of cores in your CPU. It must not be more than CPU's cores.
- `RAILS_MAX_THREADS` should be less or equal to `16`
- `DB_MAX_POOL` must be less or equal to (`RAILS_MAX_THREADS` * `RAILS_WEB_CONCURRENCY`)
- MySQL's default setting of `MAX_POOL` is `100`
3. **Install gems**
```
bundle install
```
4. **Install yarn for webpack**
```
yarn install
```
5. **Create database and seed data**
```
rails db:create db:migrate db:seed
```
6. **Run rails server**
```
rails s
```
7. **For developing**
Run webpack server to compile javascript/css files immediately
```
bin/webpack-dev-server
```


# Syntax validation
Check ruby syntax
```
bundle exec rubocop
```
Check slim syntax
```
slim-lint app/**/*.slim
```
Check stylesheets syntax
```
bundle exec scss-lint app/javascript/assets/stylesheets
```
Check javascript syntax
```
eslint app/javascript/
```
