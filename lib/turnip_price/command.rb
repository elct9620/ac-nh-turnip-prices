# frozen_string_literal: true

require 'optparse'
require 'turnip_price/calculator'

module TurnipPrice
  # Command Interface
  #
  # @since 0.1.0
  class Command < OptionParser
    # @since 0.1.0
    HEADER = %w[- Sun Mon Tue Wed Thu Fri Sat]
    ROW_HEADER = %w[Morning Afternoon]

    # :nodoc:
    def initialize(&block)
      super

      on('-p', '--pattern=PATTERN', 'Current pattern (0 ~ 3)') do |v|
        @pattern = v.to_i
      end

      on('-s', '--seed=SEED', 'The seed number, default is current time') do |v|
        @seed = v.to_i
      end
    end

    # :nodoc:
    def parse!(argv = default_argv, into: nil)
      super

      calculator = Calculator.new(@pattern, @seed || Time.now.to_i)
      prices = calculator.exec
      display prices
    end

    private

    # Display Prices
    #
    # @param prices [Array<Array<Number>>]
    #
    # @since 0.1.0
    def display(prices)
      printable_prices = prices.unshift(ROW_HEADER).transpose
      table = TTY::Table.new(HEADER, printable_prices)
      puts table
        .render(:unicode, padding: [0, 1], alignment: [:left, :right])
    end
  end
end
