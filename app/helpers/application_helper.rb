module ApplicationHelper
  ALERTS = {alert: 'alert-danger', notice: 'alert-primary', hello: 'alert-success'}.freeze

  def year
    Date.current.year
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: "_blank"
  end

  def link_to_admin_panel
    link_to t('nav.admin'), admin_tests_path, class: 'btn btn-warning btn-sm' if user_signed_in? && current_user.admin?
  end

  def output_flash
    return if flash.nil?

    messages = ''
    
    flash.each do |key, message|
      alert_class = ALERTS[key.to_sym] || 'alert-info'
      messages += content_tag :div, message, class: ['alert', alert_class], role: 'alert'
    end

    messages.html_safe
  end
end
