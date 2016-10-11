require_relative 'test_helper'
require_relative '../lib/markup_calculator'

class MarkupCalculatorTest < Minitest::Test
  def test_base_price_argument_is_required
    invalid_arguments = valid_arguments.tap { |hash| hash.delete(:base_price) }
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'missing keyword: base_price', error.message
  end

  def test_people_argument_is_required
    invalid_arguments = valid_arguments.tap { |hash| hash.delete(:people) }
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'missing keyword: people', error.message
  end

  def test_material_argument_is_required
    invalid_arguments = valid_arguments.tap { |hash| hash.delete(:material) }
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'missing keyword: material', error.message
  end

  def test_calculate_requires_base_price_to_be_numeric
    invalid_arguments = valid_arguments.merge(base_price: 'not numeric')

    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments).calculate
    end

    assert_match 'must be numeric: base_price', error.message
  end

  def test_calculate_requires_base_price_to_be_positive
    invalid_arguments = valid_arguments.merge(base_price: -1)

    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments).calculate
    end

    assert_match 'must be positive: base_price', error.message
  end

  def test_calculate_requires_people_to_be_numeric
    invalid_arguments = valid_arguments.merge(people: 'not numeric')

    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments).calculate
    end

    assert_match 'must be numeric: people', error.message
  end

  def test_calculate_requires_people_to_be_positive
    invalid_arguments = valid_arguments.merge(people: -1)

    error = assert_raises ArgumentError do
      MarkupCalculator.new(**invalid_arguments).calculate
    end

    assert_match 'must be positive: people', error.message
  end

  def test_calculate_returns_expected_price_for_food_and_three_people
    calculator = MarkupCalculator.new(
      base_price: 1_299.99,
      people:     3,
      material:   'food'
    )
    expected_output = 1_591.58

    assert_equal expected_output, calculator.calculate
  end

  def test_calculate_returns_expected_price_for_drugs_and_one_person
    calculator = MarkupCalculator.new(
      base_price: 5_432.00,
      people:     1,
      material:   'drugs'
    )
    expected_output = 6_199.81

    assert_equal expected_output, calculator.calculate
  end

  def test_calculate_returns_expected_price_for_books_and_four_people
    calculator = MarkupCalculator.new(
      base_price: 12_456.95,
      people:     4,
      material:   'books'
    )
    expected_output = 13_707.63

    assert_equal expected_output, calculator.calculate
  end

  private

  def valid_arguments
    {
      base_price: 1_299.99,
      people:     3,
      material:   'food',
    }
  end
end
