class SectiontemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @templates=Sectiontemplate.where(company_id:current_user.company_id)
  end

  def new
    @section=Sectiontemplate.new
  end

  def update
    @template=Sectiontemplate.find(params[:id])
    @template.update_attributes(params[:name]=>params[:value])
  end

  def get_section_names
    @templates=Sectiontemplate.all_templates(current_user.company_id)
    render json:@templates.map{|x| x[:name]}
  end

  def create
    @section=Sectiontemplate.new
    @section.name=get_params[:name]
    @section.subject=get_params[:subject]
    @section.user_id=current_user.id
    @section.company_id=current_user.company_id
    @section.yeni!
    @section.save
    redirect_to action:"index", notice: "Sözleşme bölüm taslağı yaratıldı."
  end

  private

  def get_params
    params.require(:sectiontemplate).permit(:name,:subject)
  end
end
