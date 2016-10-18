require_relative 'errors'
require_relative 'thesaurus'

class MarkupCalculator
  include Errors

  FLAT_MARKUP       = 0.05
  MATERIAL_MARKUP   = {
    electronics:    0.02,
    food:           0.13,
    pharmaceutical: 0.075,
  }
  PER_PERSON_MARKUP = 0.012
  PRICE_PRECISION = 2

  def initialize(base_price:, people:, material:)
    @base_price = base_price
    @people = people
    @material = material.to_sym

    validate_base_price
    validate_people
  end

  def calculate
    full_price = apply_other_markups(price: apply_flat_markup(price: base_price), people: people, material: material)

    printable(full_price)
  end

  private

  attr_reader :base_price, :people, :material

  def apply_flat_markup(price:)
    price * (1 + FLAT_MARKUP)
  end

  def apply_other_markups(price:, people:, material:)
    price * (1 + people_markup(people) + material_markup(material))
  end

  def people_markup(people)
    people * PER_PERSON_MARKUP
  end

  def material_markup(material)
    if any_markup_for?(material)
      MATERIAL_MARKUP[material]
    elsif material_synonym = Thesaurus.new(material).synonym
      MATERIAL_MARKUP[material_synonym]
    else
      0
    end
  end

  def any_markup_for?(material)
    MATERIAL_MARKUP.keys.include?(material)
  end

  def printable(price)
    price.round(PRICE_PRECISION)
  end

  def validate_base_price
    raise NonPositiveBasePriceError unless @base_price.positive?
  rescue NoMethodError => e
    if e.message.match(/positive\?/)
      raise NonNumericBasePriceError
    else
      raise
    end
  end

  def validate_people
    raise NonPositivePeopleError unless @people.positive?
  rescue NoMethodError => e
    if e.message.match(/positive\?/)
      raise NonNumericPeopleError
    else
      raise
    end
  end
end
