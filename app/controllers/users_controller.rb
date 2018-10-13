class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_account_access]
  before_action :ensure_that_signed_in, only: [:show]
  before_action :ensure_admin_status, only: [:destroy, :toggle_account_access]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user == current_user
      respond_to do |format|
        if user_params[:username].nil? && @user == current_user && @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to users_url, notice: "No access."
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      reset_session
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to users_url
    end
  end

  def toggle_account_access
    if current_user.admin == true && !@user.admin == true
      @user.update_attribute :access, !@user.access
      respond_to do |format|
        format.html { redirect_to users_url, notice: "Access for #{@user.username} was successfully changed." }
        format.json { head :no_content }
      end
    else
      redirect_to users_url
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
