class QuestionsController < ApplicationController
  before_action :find_test, :find_question

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  def index
    render plain: @test.questions.pluck(:body)
  end

  def show
    render plain: @question.body
  end

  def new
    render :new, layout: false
  end

  def create
    question = @test.questions.create(question_params)

    render plain: question.inspect
  end

  def destroy
    test = @question.test

    @question.destroy
    
    redirect_to test_questions_path(test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id]) if params[:test_id]
  end

  def find_question
    @question = Question.find(params[:id]) if params[:id]
  end

  def rescue_record_not_found
    render plain: "404 Not Found", status: 404
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
