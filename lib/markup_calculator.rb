class MarkupCalculator
  FLAT_MARKUP_PERCENTAGE        = 5
  MATERIAL_MARKUP_PERCENTAGE    = { food: 13 }
  PER_PERSON_MARKUP_PERCENTAGE  = 1.2

  attr_reader :base_price, :people, :material

  def initialize(base_price:, people:, material:)
    @base_price = base_price
    @people = people
    @material = material.to_sym
  end

  def calculate
    price_with_flat_markup = apply_flat_markup(price: base_price)
    apply_other_markups(price: price_with_flat_markup, people: people, material: material)
  end

  private

  def apply_flat_markup(price:)
    price * (100 + FLAT_MARKUP_PERCENTAGE) / 100
  end

  def apply_other_markups(price:, people:, material:)
    (price * (100 + people_markup(people) + material_markup(material)) / 100).round(2)
  end

  def people_markup(people)
    people * PER_PERSON_MARKUP_PERCENTAGE
  end

  def material_markup(material)
    return 0 unless MATERIAL_MARKUP_PERCENTAGE.keys.include?(material)
    MATERIAL_MARKUP_PERCENTAGE[material]
  end
end
