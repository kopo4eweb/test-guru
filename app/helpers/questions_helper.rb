module QuestionsHelper
  def question_header
    if @test
      "Create New <#{@test.title}> Question"
    else
      "Edit <#{@question.test.title}> Question"
    end
  end
end
