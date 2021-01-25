module ManageBadge
  
  class BadgeChecker < ApplicationService
    attr_reader :test_passage, :test
    attr_accessor :user

    def initialize(test_passage)
      @test_passage = test_passage
      @user = test_passage.user
      @test = test_passage.test
    end

    def call
      add_badges
    end

    private

    def add_badges
      logger = Rails.logger

      badge_group_counts = Badge.user_group_badges_count(user)

      Badge.show_active.each do |badge|
        next if skip_add_badge?(badge, badge_group_counts)

        begin
          if RulesChecker.call(test_passage, badge.rule)
            self.user.user_badges.new(badge: badge, test: test).save!
          end
        rescue ScriptError => e
          logger.error "Error in a rule: #{badge.rule}"
          logger.error e.message
          logger.error e.backtrace.join("\n")
        end
      end
    end

    def skip_add_badge?(badge, badge_group_counts)
      # если такой бейдж назначен за этот тест, пропусткаем, не назначаем
      # or
      # Если лимит позволяет использовать этот бейдж у этого пользователя, есть бейджи которые пользователь может получить только 1 раз
      user.user_badges.where(badge: badge, test: test.id).size > 0 || badge.usage_limit <= badge_group_counts[badge.id].to_i
    end
  end
end