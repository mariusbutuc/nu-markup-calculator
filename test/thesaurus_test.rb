require_relative 'test_helper'
require_relative '../lib/thesaurus'

class ThesaurusTest < Minitest::Test
  def test_synonym_returns_nil_when_none_exists
    thesaurus = Thesaurus.new(:no_synonym_here)
    assert_nil thesaurus.synonym
  end

  def test_synonym_returns_expected_value_when_one_exists
    thesaurus = Thesaurus.new(:drugs)
    assert_equal :pharmaceutical, thesaurus.synonym
  end
end
