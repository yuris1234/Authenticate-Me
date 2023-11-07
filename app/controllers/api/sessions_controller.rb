class Api::SessionsController < ApplicationController
  def show
    if current_user 
      render json: {user: current_user}
    else
      render json: {user: nil}
    end
  end

  def create
    username = params[:credential]
    password = params[:password]
    @user = User.find_by_credentials(username, password)
    if @user
      login!(@user)
      render json: {user: @user}
    else
      render json: {errors: ['Invalid credentials']}, status: :unauthorized
    end
  end

  def destroy
    if current_user
      logout!
      render json: {message: 'success'}
    end
  end

end
