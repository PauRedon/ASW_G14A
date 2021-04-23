class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy login ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end
  
  def update_username
    @user.update(params[:username])
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
    respond_to do |format|
      if @user.update(user_params_edit)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
