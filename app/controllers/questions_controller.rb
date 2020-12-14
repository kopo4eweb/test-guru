class QuestionsController < ApplicationController
  before_action :find_test
  before_action :find_question, except: [:index, :create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  def index
    @questions = @test.questions
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    
    redirect_to test_path(@question.test)
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
