class TestPassagesController < ApplicationController
  before_action :set_test_passages, only: %i[show result update gist]

  def show
    redirect_to result_test_passage_path(@test_passage) if @test_passage.current_question.nil?
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now if @test_passage.success?
      
      ManageBadge::BadgeChecker.call(@test_passage) if @test_passage.success?

      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call

    if service.success?
      flash_options = { notice: t('.success', url: view_context.link_to(t('.address'), result.html_url, target: '_blank')) }

      create_gist(result.html_url)
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passages
    @test_passage = TestPassage.find(params[:id])
  end

  def create_gist(gist_url)
    @test_passage.current_question.gists.create({
      url: gist_url,
      user: current_user
    })
  end
end
