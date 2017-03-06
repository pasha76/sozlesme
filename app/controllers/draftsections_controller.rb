class DraftsectionsController < ApplicationController
  before_action :authenticate_user!

  def update
    section=Draftsection.find(params[:id])
    section.update_attributes(params[:name] => params[:value])
    render json: section
  end

  def create
    @draftagreement=Draftagreement.find(section_params[:draftagreement_id])
    @draftagreement.order_no=@draftagreement.order_no.to_i+1
    @draftagreement.save

    @draftsection=Draftsection.new
    @draftsection.company_id=current_user.company_id
    @draftsection.user_id=current_user.id
    @draftsection.draftagreement_id=section_params[:draftagreement_id]
    @draftsection.name=Sectiontemplate.find(section_params[:name]).name
    @draftsection.order_no=@draftagreement.order_no
    @draftsection.save

    redirect_to @draftagreement, notice:"Sözleşmeye "+section_params[:name]+" bölümü eklenmiştir."
  end

  def section_params
    params.require(:draftsection).permit(:name,:draft_id,:draftagreement_id,:sections)
  end
end
