class SessionsController < ApplicationController
  def new
  end

 def create
   @user = User.find_by(email: params.fetch("email_from_query"))
   if @user && @user.authenticate(params.fetch("password_from_query"))
      redirect_to '/welcome'
      session[:user_id] = @user.id
   else
      redirect_to("/login", alert: "User Account not found")
   end
end

  def login
  end
  
  def logout
    session[:user_id] = nil
    redirect_to '/welcome'
  end

  def welcome
  end
end
