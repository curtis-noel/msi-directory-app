class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @users = User.all
    @user_records = ['name',
                     'username',
                     'email',
                     'sign_in_count',
                     'last_sign_in_at']
  end

  def show
    @user = User.find(params[:id])
    @user_row_data = [['Name:', @user.name], ['Username:', @user.username], ['Email:', @user.email], ['Sign In Count:', @user.sign_in_count], ['Last Sign In At:', @user.last_sign_in_at]]
  end

  def new
    @user = User.new
    @user_fields = [[[:username, 'text_field']]]
  end

  def create
    @user_fields = [[[:name, 'text_field'], [:username, 'text_field'], [:email, 'text_field']]]
    @user = User.new(user_params)
    if user.save
      redirect_to users_path, notice: 'User was sucessfully created.'
    else
      render :new
    end
  end

  def edit
    @user_fields = [[[:name, "text_field"], [:username, "text_field"], [:email, "text_field"]]]
  end

  def update
    @user_fields = [[[:name, "text_field"], [:username, "text_field"], [:email, "text_field"]]]
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:email,
                                   :remember_created_at,
                                   :sign_in_count,
                                   :current_sign_in_at,
                                   :last_sign_in_at,
                                   :created_at,
                                   :updated_at,
                                   :name,
                                   :username)
  end
end
