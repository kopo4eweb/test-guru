class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :set_test, only: %i[edit show update destroy update_inline]

  def index
  end

  def show
    @test = Test.find(params[:id])
  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.new(test_params)

    if @test.save
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: t('.success', title: @test.title)
  end

  private

  def set_tests
    @tests = Test.all
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :public, :level, :category_id, :time_for_test)
  end
end
