class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index 
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def new 
        puts "user and new controller hit"
        @user = User.new
    end

    def show 
        # @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def edit 
        # @user = User.find(params[:id])
    end

    def update 
        # @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "Successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create 
        puts "Creating users"
        @user = User.new(user_params)

        if @user.save 
            session[:user_id] = @user.id
            flash[:notice] = "Welcome, user successfully created #{ @user.username }"
            redirect_to articles_path
        else
            render 'new'
        end

    end

    def destroy 
        puts "destroying 48039"
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account deleted"
        redirect_to articles_path
    end

    private

    def user_params 
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user 
        @user = User.find(params[:id])
    end

    def require_same_user 
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit your own profile"
            redirect_to @user
        end
    end

end