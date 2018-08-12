class UsersController < ApplicationController
  # POST /users.json
  def create
    @user = User.new

    respond_to do |format|
      if @user.save
        format.json { render json: @user.key, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
