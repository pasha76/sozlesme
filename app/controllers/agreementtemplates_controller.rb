class AgreementtemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @templates=Agreementtemplate.all_templates(current_user.company_id)
  end

  def get_agreement_titles
    @templates=Agreementtemplate.all_templates(current_user.company_id)
    render json:@templates.map{|x| x[:name]}
  end
  def update
    @template=Agreementtemplate.find(params[:id])
    @template.update_attributes(params[:name]=>params[:value])
  end

  def new
    @template=Agreementtemplate.new
  end
  def show
    @template=Agreementtemplate.find(params[:id])
  end

  def in_use

    redirect_to action: "index",:notice=> "Başlık kullanıma alındı."
  end

  def create
    @template=Agreementtemplate.new
    @template.name=get_params[:name]
    @template.subject=get_params[:subject]
    @template.user_id=current_user.id
    @template.draft!
    @template.company_id=current_user.company_id
    @template.save
    redirect_to action:"index", :notice => "Sözleşme başlık taslağı yaratıldı."
  end

  def get_params
    params.require(:agreementtemplate).permit(:name,:subject)
  end

end
