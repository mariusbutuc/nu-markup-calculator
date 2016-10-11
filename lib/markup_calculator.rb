class MarkupCalculator
  FLAT_MARKUP       = 0.05
  MATERIAL_MARKUP   = {
    pharmaceutical: 0.075,
    food:           0.13,
    electronics:    0.02,
  }
  PER_PERSON_MARKUP = 0.012

  attr_reader :base_price, :people, :material

  def initialize(base_price:, people:, material:)
    @base_price = base_price
    @people = people
    @material = material.to_sym
  end

  def calculate
    apply_other_markups(price: apply_flat_markup(price: base_price), people: people, material: material)
  end

  private

  def apply_flat_markup(price:)
    price * (1 + FLAT_MARKUP)
  end

  def apply_other_markups(price:, people:, material:)
    exact_price = price * (1 + people_markup(people) + material_markup(material))
    exact_price.round(2)
  end

  def people_markup(people)
    people * PER_PERSON_MARKUP
  end

  def material_markup(material)
    return 0 unless MATERIAL_MARKUP.keys.include?(material)

    MATERIAL_MARKUP[material]
  end
end
