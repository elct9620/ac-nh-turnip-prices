# frozen_string_literal: true

require 'turnip_price/pattern'
require 'turnip_price/formula/fluctuating'
require 'turnip_price/formula/large_spike'
require 'turnip_price/formula/decreasing'
require 'turnip_price/formula/small_spike'

module TurnipPrice
  # Turnip Price Formula
  module Formula
    # @since 0.1.0
    PATTERN = {
      Pattern::FLUCTUATING => Fluctuating,
      Pattern::LARGE_SPIKE => LargeSpike,
      Pattern::DECREASING  => Decreasing,
      Pattern::SMALL_SPIKE => SmallSpike
    }

    module_function

    # Create formula object
    #
    # @param pattern [Number] pattern ID
    # @param random [SEAD::Random] the generator
    #
    # @return [TurnipPrice::Formula::Base] forumla object
    #
    # @since 0.1.0
    def create(pattern, base_price, random)
      klass = PATTERN[pattern]
      klass.new(base_price, random)
    end
  end
end
