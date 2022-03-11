# SimpleRent Tenant Application API

## Prerequisites
[![Ruby Style Guide](https://img.shields.io/badge/ruby-3.1.0-brightgreen)](https://rubystyle.guide)
[![Ruby Style Guide](https://img.shields.io/badge/rails-7.0.2-brightgreen)](https://rubystyle.guide)

### First-time setup
1. install Ruby
2. download and install postgresql. https://www.postgresql.org/download
3. **Run** the following command.
```bash
$ gem install rails
```

## Database and Master key
Ask for the database.yml and master.key files.

### Setup Database
```bash
$ rails db:create
```
```bash
$ rails db:migrate
```
```bash
$ rails db:seed
```

## Running app on localhost
1. Follow the instructions in **First-time setup**.
2. Get a copy of `database.yml` and `master.key`.
3. Clone the repository.
4. **Run** the following command to setup the project.
```bash
$ cd mini-parking-api
```
```bash
$ bundle install
```
5. Copy the `database.yml` and `master.key` to `/config`.
6. Make sure that the postgresql is running. (In Ubuntu's case, run the following command)
```bash
$ sudo service postgresql start
```
7. **Run** the following command to setup the database.
```bash
$ rails db:create db:migrate db:seed
```
8. **Run** the application.
```bash
$ rails s
```
The server will run on **localhost:3000**.