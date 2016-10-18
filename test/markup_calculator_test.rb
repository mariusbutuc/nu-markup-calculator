require_relative 'test_helper'
require_relative '../lib/markup_calculator'

class MarkupCalculatorTest < Minitest::Test
  def test_base_price_argument_is_required
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**arguments_without(:base_price))
    end

    assert_match 'missing keyword: base_price', error.message
  end

  def test_base_price_needs_to_be_numeric
    invalid_arguments = valid_arguments.merge(base_price: 'not numeric')

    error = assert_raises MarkupCalculator::NonNumericBasePriceError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'must be numeric: base_price', error.message
  end

  def test_base_price_needs_to_be_positive
    invalid_arguments = valid_arguments.merge(base_price: -1)

    error = assert_raises MarkupCalculator::NonPositiveBasePriceError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'must be positive: base_price', error.message
  end

  def test_people_argument_is_required
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**arguments_without(:people))
    end

    assert_match 'missing keyword: people', error.message
  end

  def test_people_needs_to_be_numeric
    invalid_arguments = valid_arguments.merge(people: 'not numeric')

    error = assert_raises MarkupCalculator::NonNumericPeopleError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'must be numeric: people', error.message
  end

  def test_people_needs_to_be_positive
    invalid_arguments = valid_arguments.merge(people: -1)

    error = assert_raises MarkupCalculator::NonPositivePeopleError do
      MarkupCalculator.new(**invalid_arguments)
    end

    assert_match 'must be positive: people', error.message
  end

  def test_material_argument_is_required
    error = assert_raises ArgumentError do
      MarkupCalculator.new(**arguments_without(:material))
    end

    assert_match 'missing keyword: material', error.message
  end

  def test_calculator_applies_electronics_category_markup
    calculator = MarkupCalculator.new(
      base_price: 5_432.99,
      people:     2,
      material:   'electronics'
    )
    expected_output = 5_955.64

    assert_equal expected_output, calculator.calculate
  end

  def test_calculator_applies_food_category_markup
    calculator = MarkupCalculator.new(
      base_price: 1_299.99,
      people:     3,
      material:   'food'
    )
    expected_output = 1_591.58

    assert_equal expected_output, calculator.calculate
  end

  def test_calculator_applies_pharmaceutical_category_markup
    calculator = MarkupCalculator.new(
      base_price: 5_432.00,
      people:     1,
      material:   'pharmaceutical'
    )
    expected_output = 6_199.81

    assert_equal expected_output, calculator.calculate
  end

  def test_calculator_applies_pharmaceutical_category_markup_for_drugs_synonym
    calculator = MarkupCalculator.new(
      base_price: 5_432.00,
      people:     1,
      material:   'drugs'
    )
    expected_output = 6_199.81

    assert_equal expected_output, calculator.calculate
  end

  def test_calculator_applies_no_extra_markup_for_unhandled_markup_categories
    calculator = MarkupCalculator.new(
      base_price: 12_456.95,
      people:     4,
      material:   'books'
    )
    expected_output = 13_707.63

    assert_equal expected_output, calculator.calculate
  end

  private

  def arguments_without(key)
    valid_arguments.tap { |hash| hash.delete(key) }
  end

  def valid_arguments
    {
      base_price: 1_299.99,
      people:     3,
      material:   'food',
    }
  end
end
