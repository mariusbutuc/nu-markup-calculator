class MarkupCalculator
  FLAT_MARKUP       = 0.05
  MATERIAL_MARKUP   = {
    pharmaceutical: 0.075,
    food:           0.13,
    electronics:    0.02,
  }
  PER_PERSON_MARKUP = 0.012
  SYNONYMS = [
    %i(pharmaceutical drugs),
  ].freeze.map(&:freeze)

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
    if any_markup_for?(material)
      MATERIAL_MARKUP[material]
    elsif material_synonym = synonym_for(material)
      MATERIAL_MARKUP[material_synonym]
    else
      0
    end
  end

  def any_markup_for?(material)
    MATERIAL_MARKUP.keys.include?(material)
  end

  def synonym_for(material)
    synonyms_pair = SYNONYMS.detect { |pair| pair.include?(material) }

    return if synonyms_pair.nil?

    (synonyms_pair - Array(material)).first
  end
end
