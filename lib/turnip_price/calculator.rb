# frozen_string_literal: true

require 'sead'
require 'turnip_price/pattern'
require 'turnip_price/formula'

module TurnipPrice
  # Price Calculator
  #
  # @since 0.1.0
  class Calculator
    # @param pattern [Number] current pattern
    # @param seed [Number] the random seed
    #
    # @since 0.1.0
    def initialize(pattern, seed)
      @pattern = pattern
      @random = SEAD::Random.new(seed)
    end

    # Next Pattern
    #
    # Get next price pattern
    #
    # @return [Nubmer] next pattern ID
    #
    # @since 0.1.0
    def next_pattern
      return @next_pattern unless @next_pattern.nil?
      return @next_pattern = 2 if @pattern >= 4

      chance = @random.int(0..99)
      @next_pattern = Pattern.lookup(@pattern, chance)
    end

    # Get Prices
    #
    # Calculate next week prices
    #
    # @return [Array<Range>] next week prices
    #
    # @since 0.1.0
    def prices
      return @prices unless @prices.nil?

      base_price = @random.int(90..110)
      formula = Formula.create(@pattern, base_price, @random)
      @prices = formula.exec
    end

    alias exec prices
  end
end
