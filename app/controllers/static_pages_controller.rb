class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
      @posed_question = posed_question
      @questions = Question.all[0..9]
    end
  end

  def help
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
    end
  end

  def about
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
    end
  end

  def contact
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
    end
  end

  private
    def posed_question
      if Question.count == 0
        return nil
      end

      for try in 0..10
        random_id = rand(1..Question.count)
        
        question = Question.find(random_id)
        
        # check if current_user's question
        if question.user == current_user then
          next
        end

        # check if current_user answered it
        if Answer.find_by(user_id: current_user, question_id: question) != nil then
          next
        end

        # found question
        return question
      end

      # didn't find question in 10 tries
      return nil
    end
end
