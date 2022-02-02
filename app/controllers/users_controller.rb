class UsersController < ApplicationController

    def index 
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def new 
        puts "user and new controller hit"
        @user = User.new
    end

    def show 
        @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])
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
            flash[:notice] = "Welcome, user successfully created #{ @user.username }"
            redirect_to articles_path
        else
            render 'new'
        end

    end

    private

    def user_params 
        params.require(:user).permit(:username, :email, :password)
    end

end