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

  # GET /users/valid.json
  def valid
    user_exists = if params.key?(:key)
      User.exists?(key: params[:key])
    end

    respond_to do |format|
      if user_exists
        format.json { render json: "Valid", status: :ok }
      else
        format.json { render json: "", status: :not_found }
      end
    end
  end

  # GET /users/:id/watch_list.json
  def watch_list
    user_exists = User.exists?(key: params[:id])
    
    respond_to do |format|
      if user_exists
        # Call service here
        format.json { render json: "Valid", status: :ok }
      else
        format.json { render json: "", status: :not_found }
      end
    end
  end
end
