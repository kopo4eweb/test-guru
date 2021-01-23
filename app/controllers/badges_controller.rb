class BadgesController < ApplicationController
  def all
    @badges = Badge.show_active
  end

  def user
    @badges = current_user.badges
  end
end