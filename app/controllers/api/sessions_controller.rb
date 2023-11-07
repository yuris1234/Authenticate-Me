class Api::SessionsController < ApplicationController
  def show
    if current_user 
      @user = current_user
      render 'api/users/show'
    else
      render json: {user: nil}
    end
  end

  def create
    username = params[:credential]
    password = params[:password]
    # debugger
    @user = User.find_by_credentials(username, password)
    if @user
      login!(@user)
      # console.log('hello')
      render 'api/users/show'
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
