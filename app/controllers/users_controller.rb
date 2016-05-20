class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User #{@user.name} sign up successful!"
      redirect_to @user
    else
      flash.now[:failure] = "Sign up failed!"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    # authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    # authorize! :update, @user

    @user.attributes = user_params

    if @user.save
      own_account = current_user.id == @user.id
      flash[:success] = own_account ? 'You have successfully updated your account information' : "User #{@user.email} was updated successfully!"
      redirect_to own_account ? root_path : users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :auth_token)
    end

end
