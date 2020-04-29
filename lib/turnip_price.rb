# frozen_string_literal: true

require 'sead'
require 'turnip_price/calculator'
require 'turnip_price/command'
require 'turnip_price/server'

module TurnipPrice
  module_function

  # Run as command
  #
  # @since 0.1.0
  def run
    Command.new.parse!
  end

  # Run as Rack application
  def serve
    Server.new
  end
end
