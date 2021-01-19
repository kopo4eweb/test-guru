class BadgesController < ApplicationController
  def all
    @badges = Badge.all
  end

  def user
    @badges = current_user.badges
  end
end