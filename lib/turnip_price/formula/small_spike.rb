# frozen_string_literal: true

module TurnipPrice
  module Formula
    class SmallSpike < Base
      # :nodoc:
      #
      # @see TurnipPrice::Formula::Base#initialize
      #
      # @since 0.1.0
      def initialize(*args)
        super

        @start = @random.int(2..9)
        @pointer = @start - 1
      end

      # @see TurnipPrice::Formula::Base#exec
      #
      # @since 0.1.0
      def exec
        decrease
        spike
        decrease_remain

        @prices.each_slice(2).to_a
      end

      private

      # Decreasing Before Spike
      #
      # @since 0.1.0
      def decrease
        rate = @random.float(0.4..0.9)
        (2...@start).each do |n|
          @prices[n] = (rate * @base_price).ceil
          rate -= 0.03
          rate -= @random.float(0..0.02)
        end
      end

      # Spike
      #
      # @since 0.1.0
      def spike
        @prices[@pointer += 1] = (@random.float(0.9..1.4) * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(0.9..1.4) * @base_price).ceil
        rate = @random.float(1.4..2.0);
        @prices[@pointer += 1] = (@random.float(1.4..rate) * @base_price).ceil - 1
        @prices[@pointer += 1] = (rate * @base_price).ceil
        @prices[@pointer += 1] = (@random.float(1.4..rate) * @base_price).ceil - 1
      end

      # Decreasing Remain
      #
      # @since 0.1.0
      def decrease_remain
        rate = @random.float(0.9..0.4)
        (@pointer..13).each do |n|
          @prices[n] = (rate * @base_price).ceil
          rate -= 0.03
          rate -= @random.float(0..0.02)
        end
      end
    end
  end
end
