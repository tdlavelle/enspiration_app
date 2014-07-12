module QuestionsHelper

  def current_user_answered?(question)
    question.answers.exists? user_id: current_user.id
  end
end