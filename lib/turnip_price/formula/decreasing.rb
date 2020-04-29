# frozen_string_literal: true

module TurnipPrice
  module Formula
    class Decreasing < Base
      # @see TurnipPrice::Formula::Base#exec
      #
      # @since 0.1.0
      def exec
        rate = 0.9
        rate -= @random.float(0..0.05)
        (2..13).each do |n|
          @prices[n] = (rate * @base_price).ceil
          rate -= 0.03
          rate -= @random.float(0..0.02)
        end

        @prices.each_slice(2).to_a
      end
    end
  end
end
