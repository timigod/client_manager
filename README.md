# Motivation
To understand why this gem exists, we're going to look at a simple example of a Blog application built with a Rails API and any JavaScript front-end framework. 

In the API, you're probably going to have some endpoints that only logged in Users/Authors can access. Like creating or deleting a blog post. Other endpoints however, like reading posts, would be unauthenticated. This means that if one should go to the read endpoint with the browser, the whole JSON response would be displayed. What would be ideal, would be make it such that only the FE app can access the read endpoint(s). To do that, you might generate a random UUID and ask the FE developer to put it in the header of whatever request. But this can't "scale", what if you want to add an Android app? Or an iOS one too? That's what Client Manager does for you; helps manage all of this with a simple UI.

## Installation & Setup
1. Add `gem 'client_manager'` to your application's Gemfile, then `bundle install`.
2. Run `rails generate client_manager:install`. This creates a `client_manager.rb` file in your app's initializer's folder & inserts `include ClientManager::Concerns::SetClientByToken` into    your `ApplicationController`, to authenticate all requests. You can remove it from that controller and put it in any controller that needs client authentication.
3. Finally, you need to create a `superadmin` using `rake client_manager:superadmin NAME=Test EMAIL=test@test.com PASSWORD=password`. Remember to change the NAME, EMAIL and PASSWORD arguments. All three arguments are required.

## Usage
Client Manager is automatically hosted at `/client_manager`. There you can sign in with your superadmin credentials.

Once, signed in, you can create Client Manager Users and specify the maximum number of clients they're allowed to create. 

Users you create will get an email with their password and are required to change this on first sign in.

**Note:** Client Manager inherits from your application's `ActionMailer` settings. If you've not set up your application to send emails, client manager emails won't be sent.

## Authenticating Requests
Client applications need to add their generated tokens to the `Header` of every request like so: `client_token: <generated-token>`. You can access the client making the request within your controllers using the `current_client` helper method.

## Contributing & Todo
To contribute: fork this repo, write code & make pull request.
Some of the things I'm looking at doing in the immediate future are:
- Tests
- Basic stats: Requests per client over time
- Rate limiting client request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
