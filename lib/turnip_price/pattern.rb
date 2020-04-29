# frozen_string_literal: true

module TurnipPrice
  module Pattern
    # @since 0.1.0
    FLUCTUATING = 0
    LARGE_SPIKE = 1
    DECREASING  = 2
    SMALL_SPIKE = 3

    # Next Phase Rate
    #
    # | Type        | Fluctuating | Large Spike | Decreasing | Small Spike |
    # |-------------|-------------|-------------|------------|-------------|
    # | Fluctuating | 20%         | 30%         | 15%        | 35%         |
    # | Large Spike | 50%         | 5%          | 20%        | 25%         |
    # | Decreasing  | 25%         | 45%         | 5%         | 25%         |
    # | Small Spike | 45%         | 25%         | 15%        | 15%         |
    #
    # @since 0.1.0
    RATES = {
      FLUCTUATING => [20, 30, 15, 35],
      LARGE_SPIKE => [50, 05, 20, 25],
      DECREASING  => [25, 45, 05, 25],
      SMALL_SPIKE => [45, 25, 15, 15]
    }

    module_function

    # Lookup pattern table
    #
    # @param pattern [Number]
    # @param chance [Number] calculated chance
    #
    # @return [Number] pattern find by chance
    #
    # @since 0.1.0
    def lookup(pattern, chance)
      row = RATES[pattern]
      row.each_with_index do |rate, i|
        chance -= rate
        return row.index(rate) if chance <= 0
      end
    end
  end
end
