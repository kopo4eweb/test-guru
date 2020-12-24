module TestsHelper
  TEST_LEVELS = { 0 => :easy, 1 => :elementary, 2 => :advanced, 3 => :hard }.freeze

  def test_level(test)
    level = TEST_LEVELS[test.level]
    translated_level = I18n.t(".helpers.levels.#{level}") unless level.nil?
    translated_level || I18n.t('.helpers.levels.hero')
  end
end
