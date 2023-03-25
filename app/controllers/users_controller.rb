class UsersController < ApplicationController
   before_action :authorize, only: [:show]
     
    def create 
        user = User.create(user_params)
         if user.valid?
            session[:user_id] = user.id 
            render json: user, status: :created 
         else 
            render json: {error:[user.errors]}, status: :unprocessable_entity
         end      
    end


    def show 
        user = User.find(session[:user_id])
        render json: user
    end

    private 

    def user_params 
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

    def authorize 
        render json: {error: user.errors}, status: :unauthorized unless session.include? :user_id
    end
end
