module Fe
  class SessionsController < ApplicationController
    def login; end

    def create
      @user = User.find_by(username: params[:username])
      if !!@user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to '/app/listings'
      else
        redirect_to '/login'
      end
    end
  end
end
