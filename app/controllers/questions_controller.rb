class QuestionsController < ApplicationController

  def new
    @demand=Demand.find(params[:demand_id])
    @question=Question.find_or_create_by(demand_id:params[:demand_id])
    @question.content=@demand.content
    @question.demand_id=@demand.id
    @question.user_id=current_user.id
    @question.company_id=current_user.company_id
    @question.save
    @demand.submit_for_application! if @demand.new? or @demand.legal_review?
  end

  def create
    company=Company(get_params)
    company.save
  end

  def close
    question=Question.find(params[:question_id])
    question.save
    question.demand.accept!
    redirect_to demands_path,notice:"Talebi tamamladınız.Tebrikler."
  end

  private
  def get_params
    params.require(:question).permit(:content,:demand_id,:user_id,:company_id)
  end
end
