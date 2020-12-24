module QuestionsHelper
  def question_header(question)
    if question.persisted?
      I18n.t('.helpers.question.edit', title: question.test.title)
    else
      I18n.t('.helpers.question.create', title: question.test.title)
    end
  end
end
