require_relative 'test_helper'

class MarkupCalculatorTest < Minitest::Test
  def test_calculate_returns_expected_price_for_food_and_three_people
    @input = {
      base_price: 1_299.99,
      people:     3,
      material:   'food',
    }
    expected_output = 1_591.58

    assert_equal expected_output, calculator.calculate
  end

  private

  def calculator
    @calculator ||= MarkupCalculator.new(**@input)
  end
end
