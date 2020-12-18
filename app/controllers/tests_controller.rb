class TestsController < ApplicationController
  before_action :set_test, only: %i[edit show update destroy start]
  before_action :set_user, only: %i[start create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.author = @user

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.first
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def rescue_record_not_found
    render plain: "404 Not Found", status: 404
  end
end
