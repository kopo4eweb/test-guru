module ApplicationHelper
  def year
    Date.current.year
  end

  def github_url(author, repo)
    "<a href='https://github.com/#{author}/#{repo}' target='_blank'>#{repo}</a>".html_safe
  end
end
