# Jungle App 🌱🌿

A mini e-commerce application built with Rails 6.1 for purposes of teaching Rails by example.  I was given an existing code base in rails/ruby, and my job was to fix issues and add additional functionality.

## Description

Jungles is a webapp for a ficticious online store that sells household plants.  It is build on ruby/rails with postgres in the back end and using erb and sass to render the front end.  Uses Stripe API for purchases.

## Features (That I worked on)

* Basic administration login using 'authenticate_or_request_with_http_basic'.
* Admin users can create new categories, which can be assigned to plants.
* Admin dashboard to track sales orders and product / category totals.
* User authentication using sessions.
* Various bug fixes / enhancements regarding inconsistent displays.

Finished Stretch Goals:

* Emailer to send customers a summary of their order (see pictures).
* Using bootstrap CSS to make designs more consistent.
* Input validation for all input forms.

Unfinished Stretch Goals:

* RSpec testing.

## Branches

```
main - //demo ready
```

Other branches are features / bugfixes / css touchups.

# Final Product

!["Main Page"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/main01.png)

&ensp;

!["Input Validation"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/inputvalidation01.png)

&ensp;

!["Email Order"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/email01.png)
  
&ensp;

!["Cart"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/cart01.png)
  
&ensp;

!["Dashboard 1"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/dashboard01.png)

&ensp;

!["Dashboard 2"](https://github.com/robertshum/jungle-rails/blob/main/project_media/images/dashboard02.png)

&ensp;

## Database

If Rails is complaining about authentication to the database, uncomment the user and password fields from `config/database.yml` in the development and test sections, and replace if necessary the user and password `development` to an existing database user.

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios. 

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 6.1 [Rails Guide](http://guides.rubyonrails.org/v6.1/)
- Bootstrap 5
- PostgreSQL 9.x
- Stripe

## Getting Started

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rails db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Getting Emailer to Work

Update the .env file:
* SMTP must be set (for gmail it's smtp.gmail.com)
* Email and password login (could be a personal one)
  * if 2FA enabled, you have to add a 'App Password' under your profile (for Google), and use that as a password for your .env.