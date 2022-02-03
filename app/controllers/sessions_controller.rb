class SessionsController < ApplicationController 
    
    def new 
        puts "page new is hit"
    end

    def create 
        user = User.find_by(email: params[:session][:email].downcase)
        puts user.email
        if user && user.authenticate(params[:session][:password])
            puts "you have authenticated"
            session[:user_id] = user.id
            flash[:notice] = "Login successfully"
            redirect_to user
        else
            flash.now[:alert] = "There was something wrong with login"
            render 'new'
        end
    end

    def destroy 
        session[:user_id] = nil
        flash[:notice] = "Logged Out Successfully"
        redirect_to root_path
    end

end