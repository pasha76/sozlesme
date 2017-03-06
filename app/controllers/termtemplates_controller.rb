class TermtemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.legal?
      @templates=Termtemplate.where(company_id: current_user.company_id)
    else
      @templates=Termtemplate.where(company_id: current_user.company_id,user_id:current_user.id)
    end
  end

  def new
    @template=Termtemplate.new
  end

  def show
    @template=Termtemplate.find(params[:id])
  end


  def update
    @template=Termtemplate.find(params[:id])
    @template.update_attributes(params[:name] => params[:value])
  end

  def create
    @template=Termtemplate.new
    @template.content=get_params[:content]
    @template.subject=get_params[:subject]
    @template.keywords=get_params[:keywords]
    @template.user_id=current_user.id
    @template.yeni!
    @template.company_id=current_user.company_id
    @template.save
    redirect_to action: "index", :notice => "Sözleşme maddesi taslağı yaratıldı."
  end

  def get_params
    params.require(:termtemplate).permit(:content, :subject, :keywords)
  end
end
