class UsersController < ApplicationController
  
  def registration_form
    render("users/sign_up_form.html.erb")
  end

  def index
    @users = User.all.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user = User.where({:id => the_id }).at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("email_from_query")
    @user.password = params.fetch("password_from_query")
    @user.phone_number = params.fetch("phone_number_from_query")
    @user.role = "basic"
    session[:user_id] = @user.id 

    if @user.valid?
      @user.save
      redirect_to("/welcome", { :notice => "User created successfully." })
    else
      redirect_to("/welcome", { :notice => "User failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user = User.where({ :id => the_id }).at(0)

    @user.email = params.fetch("email_from_query")
    @user.password = params.fetch("password_from_query")
    @user.phone_number = params.fetch("phone_number_from_query")

    if @user.valid?
      @user.save
      redirect_to("/users/#{@user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{@user.id}", { :alert => "User failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user = User.where({ :id => the_id }).at(0)

    @user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end
end
