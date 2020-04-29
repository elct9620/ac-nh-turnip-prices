# frozen_string_literal: true

module TurnipPrice
  module Formula
    # :nodoc:
    class Base
      # @param base_price [Number] base price
      # @param random [SEAD::Random] generator
      #
      # @since 0.1.0
      def initialize(base_price, random)
        @base_price = base_price
        @random = random
        @prices = Array.new(14) do |index|
          next base_price if index < 2

          0
        end
      end

      # Calculate next week prices
      #
      # @return [Array<Number>] prices
      #
      # @since 0.1.0
      def exec
        raise NotImplementError
      end
    end
  end
end
