# frozen_string_literal: true

require 'rack'
require 'json'
require 'turnip_price/calculator'

module TurnipPrice
  # Rack Application
  #
  # @since 0.1.0
  class Server
    KEYS = %w[sun mon tue wed thu fri sat]

    def call(env)
      request = Rack::Request.new(env)
      pattern = request.params['pattern'].to_i
      seed = (request.params['seed'] || Time.now).to_i
      calculator = Calculator.new(pattern, seed)
      prices = KEYS.zip(calculator.exec).to_h
      [200, { 'Content-Type' => 'application/json' }, [prices.to_json]]
    end
  end
end
