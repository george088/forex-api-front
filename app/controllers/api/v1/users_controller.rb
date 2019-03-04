class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # controller for access by api
  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      if @user.present?
        format.json { render :show, status: :created, location: @user }
      else
        format.json { render json: answer('No such user; check the submitted apikey'), status: :bad_request }
      end
    end
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # get apikey by email
  def api_key_by_email
    respond_to do |format|
      format.json { render json: answer(get_key_by_email), status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # get user by apikey
    def set_user
      @user = User.find_by(apikey: params[:key])
    end

    def get_key_by_email
      if User.exists?(email: params[:email])
        'No such user; check the submitted email'
      else
        "#{User.where(email: params[:email])}"
      end
      # return render json: 'email user not_found', status: :not_found unless 
      # render json: {'apikey' => User.where(email: params[:email]).pluck(:apikey)[0], status: :ok}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    # answer for json
    def answer message_str
     { 
        error: message_str,
        status: 400
      }
    end
end
