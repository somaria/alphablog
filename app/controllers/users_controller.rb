class UsersController < ApplicationController

    def new 
        puts "user and new controller hit"
        @user = User.new
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