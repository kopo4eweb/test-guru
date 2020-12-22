module ApplicationHelper
  def year
    Date.current.year
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: "_blank"
  end

  def output_flash
    messages = ''
    
    flash.each do |key, message|
      messages += content_tag :p, message, class: ['flash', key]
    end unless flash.nil?

    messages.html_safe
  end
end
