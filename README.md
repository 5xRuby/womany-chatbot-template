Womany Chatbot Template
===

This is a Rails Template for Womany events.

## Usage

```bash
rails new PROJECT_NAME -m https://raw.githubusercontent.com/5xRuby/womany-chatbot-template/master/rails_template.rb
```

### Setup

For development, add your Facebook Messenger `access_token` into `.env` file

```bash
ACCESS_TOKEN=(YOUR_FAN_PAGE_ACCESS_TOKEN)
APP_SECRET=(YOUR_FACEBOOK_APP_SECRET)
# For first time setup, you may want to use `rake secret` to generate `VERIFY_TOKEN` for facebook.
VERIFY_TOKEN=
```

After setup Facebook Messenger, go to Facebook App and verify Messenger's Webhook and subscribe it.

### Development

An example file is put in `app/bot/message.rb`

```ruby
include Facebook::Messenger

Bot.on :message do |message|
  # TODO: Make bot replay something
  message.reply(text: 'Hello, human!')
end
```

Add your code to handle the message and reply user.

More supported event can reference [facebook-messenger](https://github.com/jgorset/facebook-messenger) gem.
