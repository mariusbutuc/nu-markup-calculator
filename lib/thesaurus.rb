class Thesaurus
  SYNONYMS = [
    %i(pharmaceutical drugs),
  ].freeze.map(&:freeze)

  attr_reader :base_word

  def initialize(base_word)
    @base_word = base_word.to_sym
  end

  def synonym
    return if synonym_pair.nil?
    (synonym_pair - Array(base_word)).first
  end

  private

  def synonym_pair
    # Assumption: We have only one synonym per base word
    SYNONYMS.detect { |pair| pair.include?(base_word) }
  end
end
