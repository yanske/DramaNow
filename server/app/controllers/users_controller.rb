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

  # GET /users/{#key}.json
  def valid
    user_exists = if params.key?(:key)
      User.exists?(key: params[:key])
    end

    respond_to do |format|
      if user_exists
        format.json { render json: "Valid", status: :ok }
      else
        format.json { render json: "", status: :unauthorized }
      end
    end
  end
end
