# frozen_string_literal: true

module TurnipPrice
  module Formula
    class LargeSpike < Base
      # :nodoc:
      #
      # @see TurnipPrice::Formula::Base#initialize
      #
      # @since 0.1.0
      def initialize(*args)
        super

        @start = @random.int(3..9)
        @pointer = @start - 1
      end

      # @see TurnipPrice::Formula::Base#exec
      #
      # @since 0.1.0
      def exec
        decrease
        spike
        random_low

        @prices.each_slice(2).to_a
      end

      private

      # Decreasing Middle
      #
      # @since 0.1.0
      def decrease
        rate = @random.float(0.9..0.85)
        (2...@start).each do |n|
          @prices[n] = (@base_price * rate).ceil
          rate -= 0.03
          rate -= @random.float(0..0.02)
        end
      end

      # Spike
      #
      # @since 0.1.0
      def spike
        @prices[@pointer += 1] = (@random.float(0.9..1.4) * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(1.4..2.0) * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(2.0..6.0) * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(1.4..2.0) * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(0.9..1.4) * @base_price).ceil
      end

      # Random Low
      #
      # @since 0.1.0
      def random_low
        return if @pointer >= 13

        (@pointer..13).each do |n|
          @prices[n] = (@random.float(0.4..0.9) * @base_price).ceil
        end
      end
    end
  end
end
