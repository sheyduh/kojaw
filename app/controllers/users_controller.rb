class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
    def index
      @search = User.search(params[:q])
      @users  = params[:distinct].to_i.zero? ?
        @search.result :
        @search.result(distinct: true)

    end
    
    def search
      @search = User.search(params[:q])
      @users = @search.result
    end 

    def advanced_search
      @search = User.search(params[:q])
      @search.build_grouping unless @search.groupings.any?
      @users  = params[:distinct].to_i.zero? ?
        @search.result :
        @search.result(distinct: true)

      respond_with @users
    end
    
    def show
      @user = User.find(params[:id])
    end
  def new
    @user = User.new
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  def create
      @user = User.new(user_params)
      if @user.save
        Notifier.send_signup_email(@user).deliver
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
    end
    end
    def edit
        @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

    private

        def user_params
          params.require(:user).permit(:name, :email, :password,
                                       :password_confirmation, :address, :category, :zipcode, :phone, :city, :other)
        end
        
        # Before filters

        def signed_in_user
          unless signed_in?
            store_location
            redirect_to signin_url, notice: "Please sign in."
          end
        end

        def correct_user
          @user = User.find(params[:id])
          redirect_to(root_url) unless current_user?(@user)
        end
        def admin_user
          redirect_to(root_url) unless current_user.admin?
        end
    end
    