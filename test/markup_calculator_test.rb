require_relative 'test_helper'
require_relative '../lib/markup_calculator'

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

  def test_calculate_returns_expected_price_for_drugs_and_one_person
    @input = {
      base_price: 5_432.00,
      people:     1,
      material:   'drugs',
    }
    expected_output = 6_199.81

    assert_equal expected_output, calculator.calculate
  end

  def test_calculate_returns_expected_price_for_books_and_four_people
    @input = {
      base_price: 12_456.95,
      people:     4,
      material:   'books',
    }
    expected_output = 13_707.63

    assert_equal expected_output, calculator.calculate
  end

  private

  def calculator
    @calculator ||= MarkupCalculator.new(**@input)
  end
end
