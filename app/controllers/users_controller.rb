class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]  
  def show
    if signed_in?

    end
    @user = User.find(params[:id])
  end
  
  def professionals
    @professionals = User.where("role = ?", 'professional')
  end

  def teachers
    @teachers = User.where("role = ?", 'teacher')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Inspire Us!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if signed_in?
      @new_question = current_user.questions.build
      3.times { @new_question.responses.build }
    end    
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
