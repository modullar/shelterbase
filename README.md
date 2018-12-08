# Requirements:

* Ruby version: 2.5.1
* Rails version: 5.2.1
* Postgres database



# Run Applicatoin:
From the command line do the following

* `bundle install`

## Database creation
Edit your username and password from `database.yml` file.

* `bundle exec rake db:create db:schema:load db:migrate db:seed`
### Run the test 
To run the test
* `bundle exec rspec`

You could also visit http://localhost:3000/api-docs/ and test the API directly from there.

# Authentication:

You need to authenticate as a client(customer) to perform the operations that the customer(client) is allowed to perform. 
How to do that?

Login using client@client.de & password: '123' through the `user_token` endpoint to obtain a `JWT` token. After that, use this token to authorize you're operations.

