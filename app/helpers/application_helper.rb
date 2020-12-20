module ApplicationHelper
  def year
    Date.current.year
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: "_blank"
  end

  def output_flash(type)
    if flash[type]
      content_tag :p, flash[type], class: 'flash alert'
    end
  end
end
