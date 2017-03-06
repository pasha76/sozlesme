class DemandsController < ApplicationController
  before_action :authenticate_user!

  def index

    if params[:status] then
      @demands=current_user.company.demands(params[:status])
    else
      @demands=current_user.demands
    end

  end

  def new
    @demand=Demand.new
  end

  def show
    @demand=Demand.find(params[:id])
    case @demand.current_state.to_s
      when :legal_review
        return
      when :legal_writing
        redirect_to draftagreements_path, notice: "Avukatınız taslak üerinde çalışıyor."
        return
      when :question_n_answer
        #todo yeni ekran ekle
        return
    end
  end

  def upload

    file_id=Asset.save_file(params)
    render json: {success: true, message: "success!", file_id: file_id}
  end


  def create
    @demand=Demand.new
    @demand.company_id=current_user.company_id
    @demand.user_id=current_user.id
    @demand.to_role=demand_params[:to_role]
    @demand.content=demand_params[:content]
    @demand.vendor_company_id=demand_params[:vendor_company_id]
    @demand.save
    if not demand_params[:datafile].nil?
      Asset.save_file(demand_params)
    end
    @demand.user_demandaccesses.create(user: current_user)
    user_emails=demand_params[:emails].split(",")
    @users=User.where(["email in (?)", user_emails])
    for lawyer in @users
      @demand.user_demandaccesses.create(user: lawyer)
    end
    @demand.submit_for_legal!
    redirect_to demand_path(@demand), :notice => "Talebiniz kayıt edildi."
  end

  def demand_params
    params.require(:demand).permit(:to_role, :content, :emails, :datafile,:vendor_company_id)
  end
end
