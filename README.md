# Telegram SimSimi Chatbot
This is a simple language aware Ruby chatbot for [Telegram](https://telegram.org) messenger using [SimSimi](http://www.simsimi.com) API.

This bot detect input language from a list of provided languages and get the right resposes depending on it.

You may be able to check a working example [here](https://telegram.me/that_chat_bot). (English, Persian)


## Installation

1. Clone the repository and install dependecies:
```bash
git clone https://github.com/mamal72/telegram-simsimi-chatbot
cd telegram-simsimi-chatbot
bundle install
```
1. Talk to [BotFather](https://telegram.me/botfather) and get a Telegram Bot.
1. Get your SimSimi UUID by sending a message [here](http://www.simsimi.com/storygame/main) and inspecting your requests in browser DevTools. (query string)
1. Set environment variables by editing `.env.example` file.
1. Rename `.env.example` to `.env`.
1. Start the bot by running main file:
```bash
ruby main.rb
```


## Usage

Really? Send your bot a message and see what happens! 😁


## Contribution

You can fork the repository, improve or fix it and then send the pull requests back if you want to see them here. I really appreciate that. ❤️