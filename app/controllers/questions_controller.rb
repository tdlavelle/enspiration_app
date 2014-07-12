class QuestionsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :view, :show]
  before_action :correct_user,   only: :destroy

  def create
    @new_question = current_user.questions.build(question_params)
    if @new_question.save
      flash[:success] = "Question asked!"
      
    else
      flash[:danger] = "Question not asked! Must have atleast 2 answer choices."
      #@feed_items = []
      #render 'static_pages/home'
    end
      redirect_to root_url
  end

  def destroy
    @question.destroy
    redirect_to root_url
  end

  def view
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
    end 
    @questions = Question.all.paginate(page: params[:page])
  end

  def show
    @question = Question.find(params[:id])
    session[:come_from_question] = "true"

    @new_question = current_user.questions.build
    3.times { @new_question.responses.build }
  end

  private
    def question_params
      params.require(:question).permit(:content, { responses_attributes: :content })
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
end