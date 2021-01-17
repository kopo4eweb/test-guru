class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || get_client
  end

  def call
    @client.create_gist(gits_params)
  end

  def success?
    @client.last_response.data.html_url.present?
  end

  private

  def get_client
    Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN_GIST'])
  end

  def gits_params
    {
      accept: 'application/vnd.github.v3+json',
      public: true,
      description: I18n.t('api.github.gist.descr', test: @test.title),
      files: {
        'test_guru_question.txt': {
          content: gist_content
          }
        }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:title)
    content.join("\n")
  end
end
