class UsersController < ApplicationController
  before_action :authenticate_user!
  #after_action :verify_authorized

  def route
    case current_user.role
      when "legal"
        redirect_to action: "legal_dashboard"
        return
      when "user"
        redirect_to action: "user_dashboard"
        return
      when "purchaser"
        redirect_to(current_user)
        return
      when "admin"
        render "admin"
        return
    end

  end

  def user_dashboard
    @demands=Demand.where(company_id: current_user.company_id).where(user_id: current_user.id)
  end

  def legal_dashboard
    @draftagreements=Draftagreement.where(["company_id=?", current_user.company_id])

  end

  def new_template

  end

  def index
    @users = User.all
    @companies=Company.all
    respond_to do|format|
      format.html
      format.json { render json: @users.where(company_id:current_user.company_id).map{|u|{id:u.id,name:u.email}} }
    end
  end

  def show
    @user = User.find(params[:id])
    #authorize @user
  end

  def update
    @user = User.find(params[:id])
    #authorize @user
    if params[:pk]
      @user.update_attributes(params[:name] => params[:value])
      render json:@user
      return
    elsif @user.update_attributes(params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    #authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :legal_company_id, :company_id, :id)
  end

end
