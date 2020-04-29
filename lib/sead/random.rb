# frozen_string_literal: true

module SEAD
  # SEAD Random implementation
  #
  # Reference: https://gist.github.com/kaochenlong/20d6f4e443ff6a334e928f28c73af530
  #
  # TODO: Ensure UInt32 values should masked
  #
  # @since 0.1.0
  class Random
    # @since 0.1.0
    SEED_BASE_1 = 0x6C078965
    UINT32_MASK = 0xFFFFFFFF

    # @since 0.1.0
    attr_reader :context

    # Intiialize Random
    #
    # @param seeds [Array<Number>] the seeds (max 4 seeds)
    #
    # @since 0.1.0
    def initialize(*seeds)
      @context = Array.new(4)

      return init_0 if seeds.size.zero?
      return init_1(*seeds) if seeds.size == 1
      return init_4(*seeds) if seeds.size == 4

      raise ArgumentError
    end


    # Random Boolean
    #
    # @return [Boolean] next boolean
    #
    # @since 0.1.0
    def boolean
      (u32 & 0x80000000) == 0
    end

    # Random Integer
    #
    # @return [Number] next integer
    #
    # @since 0.1.0
    def int(range)
      ((u32 * range.size) >> 32) + range.min
    end

    # Random Float
    #
    # @return [Number] next float
    #
    # @since 0.1.0
    def float(range)
      value = [(0x3F800000 | (u32 >> 9))].pack('L').unpack('f').first
      range.begin + ((value - 1.0) * (range.end - range.begin))
    end

    private

    # Initialize without seed
    #
    # @see SEAD::Random#init_1
    #
    # @since 0.1.0
    def init_0
      init_1(42069)
    end

    # Initialize with one seed
    #
    # @param seed [Number] the seed
    #
    # @since 0.1.0
    def init_1(seed)
      seed = seed & UINT32_MASK
      @context[0] = SEED_BASE_1 * (seed ^ (seed >> 30)) + 1
      @context[1] = SEED_BASE_1 * (@context[0] ^ (@context[0] >> 30)) + 2
      @context[2] = SEED_BASE_1 * (@context[1] ^ (@context[1] >> 30)) + 3
      @context[3] = SEED_BASE_1 * (@context[2] ^ (@context[2] >> 30)) + 4
    end

    # Initialize with 4 seeds
    #
    # @param seed1 [Number] the seed 1
    # @param seed2 [Number] the seed 2
    # @param seed3 [Number] the seed 3
    # @param seed4 [Number] the seed 4
    #
    # @since 0.1.0
    def init_4(seed1, seed2, seed3, seed4)
      if (seed1 | seed2 | seed3 | seed4) == 0
        seed1 = 1;
        seed2 = 0x6C078967;
        seed3 = 0x714ACB41;
        seed4 = 0x48077044;
      end

      @context[0] = seed1 & UINT32_MASK
      @context[1] = seed2 & UINT32_MASK
      @context[2] = seed3 & UINT32_MASK
      @context[3] = seed4 & UINT32_MASK
    end

    # Return UInt32
    #
    # @return [Number] next value
    #
    # @since 0.1.0
    def u32
      n = (@context[0] ^ (@context[0] << 11)) & UINT32_MASK

      @context[0] = @context[1]
      @context[1] = @context[2]
      @context[2] = @context[3]
      @context[3] = (n ^ (n >> 8) ^ @context[3] ^ (@context[3] >> 19)) & UINT32_MASK

      @context[3]
    end
  end
end
