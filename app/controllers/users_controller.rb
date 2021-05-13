class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy login ]
  skip_before_action :verify_authenticity_token

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    
  end
  
  def update_username
    if request.headers['X-API-KEY'].present? || !current_user.blank?
      @user.update(params[:username])
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end


  # GET /users/username?&&password?
  def login
    user = User.find_by(username: params[:username])
    if user.password = params[:password]
      respond_to do |format|
        format.html { redirect_to contribucios_url, notice: "User was successfully logged." }
        format.json { render :show, status: :created, location: @user }
      end
    else
      respond_to do |format|
        format.html { redirect_to contribucios_url, notice: "Something went wrong." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to contribucios_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if request.headers['X-API-KEY'].present?
      @user = User.where(id: request.headers['X-API-KEY'])
    elsif !current_user.blank?
      @user = current_user
    end
    if !@user.nil?
      if @user.update(user_params_edit)
        render json: @user.to_json
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    else
      format.json { render json:{status:"error", code:403, message: "Your api key " + request.headers['X-API-KEY'].to_s + " is not valid"}, status: :forbidden}
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        @user = nil
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password)
    end
    
    def user_params_edit
      params.require(:user).permit(:username)
    end
end
