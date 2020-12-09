class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  has_many :tests_owner, class_name: 'Test'

  def find_tests_by_level(level)
    Test.joins('JOIN passed_tests ON tests.id = passed_tests.test_id')
      .where('passed_tests.user_id = ? AND tests.level = ?', id, level)
  end
end
