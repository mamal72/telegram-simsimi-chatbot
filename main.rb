require 'dotenv'

require 'whatlanguage'
require 'httpclient'
require 'telegram/bot'

Dotenv.load

TOKEN = ENV['TELEGRAM_BOT_TOKEN']
raise 'No TELEGRAM_BOT_TOKEN ENV provided' if TOKEN.nil? || TOKEN.empty?

SIMSIMI_UUID = ENV['SIMSIMI_UUID']
raise 'No SIMSIMI_UUID ENV provided' if SIMSIMI_UUID.nil? || SIMSIMI_UUID.empty?

SIMSIMI_RETRY_COUNT = ENV['SIMSIMI_RETRY_COUNT'].to_i || 2

START_MESSAGE = ENV['START_MESSAGE'] || 'Hi! Send me some message!'
STOP_MESSAGE = ENV['STOP_MESSAGE'] || 'OK! Goodbye!'

# Add language_iso and simsimi_response methods to String class
class String
  def language_iso
    languages = ENV['LANGUAGES'].split(',').map(&:to_sym)
    WhatLanguage.new(*languages).language_iso(self) || 'en'
  end

  def simsimi_response
    retries ||= 0
    api_path = 'http://www.simsimi.com/getRealtimeReq'
    JSON.parse(
      HTTPClient.new.get(
        api_path, uuid: SIMSIMI_UUID, ft: 1, lc: language_iso, reqText: self
      ).body
    )['respSentence']
  rescue
    retry if (retries += 1) < SIMSIMI_RETRY_COUNT
    '🤔'
  end
end


Telegram::Bot::Client.run(TOKEN) do |bot|
  begin
    bot.listen do |message|
      next if message.text.nil?
      case message.text
      when '/start'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: START_MESSAGE
        )
      when '/stop'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: STOP_MESSAGE
        )
      else
        bot.api.send_message(
          chat_id: message.chat.id,
          text: message.text.simsimi_response
        )
      end
    end
  rescue
    next
  end
end
