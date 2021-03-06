module TestsHelper
  TEST_LEVELS = { 0 => :easy, 1 => :elementary, 2 => :advanced, 3 => :hard }.freeze

  def test_level(test)
    level = TEST_LEVELS[test.level]
    translated_level = I18n.t(".helpers.levels.#{level}") unless level.nil?
    translated_level || I18n.t('.helpers.levels.hero')
  end

  def test_public(test)
    return I18n.t('.helpers.publics.published') if test.public
    I18n.t('.helpers.publics.not_published')
  end

  def test_category(test, admin = false)
    return "#{test.category.title} (#{test.category.id})" if admin
    "#{test.category.title}"
  end

  def test_time(test)
    "#{I18n.t('.helpers.time_for_test', minutes: test.get_time_in_minuts)}"
  end
end
