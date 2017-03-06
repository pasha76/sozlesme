class DrafttermsController < ApplicationController
  before_action :authenticate_user!


  def create
    draftsection=Draftsection.find(get_params[:draftsection_id])
    @draftterm=Draftterm.new
    @draftterm.company_id=current_user.company_id
    @draftterm.user_id=current_user.id
    @draftterm.draftagreement_id=get_params[:draftagreement_id]
    @draftterm.draftsection_id=get_params[:draftsection_id]
    @draftterm.section_order_no=draftsection.order_no
    @draftterm.order_no=@draftterm.order_no.to_i+1
    @draftterm.content=get_params[:content]
    @draftterm.open!
    @draftterm.save
    @draftagreement=Draftagreement.find(get_params[:draftagreement_id])
    redirect_to @draftagreement, notice:"Sözleşmeye madde eklenmiştir.", anchor:"section-"+@draftterm.draftsection_id.to_s
  end

  def update
    if params[:value]
      @draftterm=Draftterm.find(params[:id])
      @draftterm.update_attributes(params[:name]=>params[:value])
      render json:@draftterm
      return
    end
    @draftterm=Draftterm.find(params[:id])
    @draftterm.content=params[:content].gsub("<p></p>","")
    @draftterm.status=params[:status]
    @draftterm.save
    render json:@draftterm
  end


  def get_params
    params.require(:draftterm).permit(:content, :draft_id, :draftsection_id, :draftagreement_id,:id,:status)
  end
end
