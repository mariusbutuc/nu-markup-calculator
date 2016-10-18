module Errors
  class NonNumericBasePriceError < ArgumentError
    def message
      'must be numeric: base_price'
    end
  end

  class NonPositiveBasePriceError < ArgumentError
    def message
      'must be positive: base_price'
    end
  end

  class NonNumericPeopleError < ArgumentError
    def message
      'must be numeric: people'
    end
  end

  class NonPositivePeopleError < ArgumentError
    def message
      'must be positive: people'
    end
  end
end
