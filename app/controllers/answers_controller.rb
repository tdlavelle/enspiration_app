class AnswersController < ApplicationController
  before_action :signed_in_user

  def create
    if users_question(params[:answer][:question_id])
      redirect_to root_path
      return
    end

    # check if current_user already answered it
    # if Answer.find_by(user_id: current_user, question_id: question) != nil then
    #   next
    # end

    @response = Response.find(params[:answer][:response_id])
    @answer = @response.answers.build(user_id: params[:answer][:user_id],
                            question_id: params[:answer][:question_id])
    if @answer.save
      flash[:success] = "Answer recorded!"
    end

    if session[:come_from_question] == "true"
      session[:come_from_question] = "false"
      redirect_to Question.find(params[:answer][:question_id])
    else
      redirect_to root_path
    end
  end

  private
    def users_question(question_id)
      question = Question.find(question_id)
      # check if current_user's question
      if question.user == current_user then
        true
      else
        false
      end
    end
end