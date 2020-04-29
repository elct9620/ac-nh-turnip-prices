# frozen_string_literal: true

require 'turnip_price/formula/base'

module TurnipPrice
  module Formula
    class Fluctuating < Base
      # :nodoc:
      #
      # @see TurnipPrice::Formula::Base#initialize
      #
      # @since 0.1.0
      def initialize(*args)
        super

        @low_phase_1 = @random.boolean ? 3 : 2
        @low_phase_2 = 5 - @low_phase_1

        @high_phase_1 = @random.int(0..6)
        @high_phase_2 = 7 - @high_phase_1
        @high_phase_3 = @random.int(0..(@high_phase_2 - 1))

        @pointer = 1
      end

      # @see TurnipPrice::Formula::Base#exec
      #
      # @since 0.1.0
      def exec
        run_high_phase(@high_phase_1)
        run_low_phase(@low_phase_1)
        run_high_phase(@high_phase_2)
        run_low_phase(@low_phase_2)
        run_high_phase(@high_phase_3)

        @prices.each_slice(2).to_a
      end

      private

      # High Phase
      #
      # @since 0.1.0
      def run_high_phase(amount)
        amount.times do
          @prices[@pointer += 1] = (@random.float(0.9..1.4) * @base_price).ceil
        end
      end

      # Low Phase
      def run_low_phase(amount)
        rate = @random.float(0.8..0.6)
        amount.times do
          @prices[@pointer += 1] = (rate * @base_price).ceil
          rate -= 0.04
          rate -= @random.float(0..0.06)
        end
      end
    end
  end
end
