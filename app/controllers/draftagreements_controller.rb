class DraftagreementsController < ApplicationController
  before_action :authenticate_user!

  def feedback_agreements
    @draftagreements=Draftagreement.where(company_id: current_user.company_id).with_getting_feedback_state
  end

  def published_agreements
    @draftagreements=Draftagreement.where(company_id: current_user.company_id).with_accepted_state
  end

  def update
    @draftagreement=Draftagreement.find(params[:id])
    @draftagreement.update_attributes(params[:name]=>params[:value])
  end
  def index
    if current_user.legal?
      @draftagreements=Draftagreement.where(company_id: current_user.company_id).with_legal_writing_state
    elsif current_user.user?
      demands=Demand.where(user_id: current_user.id)
      @draftagreements=Draftagreement.where(demand_id: demands.ids)
    end
  end

  def new
    @draftagreement=Draftagreement.new
    @agreementtemplates=Agreementtemplate.where(company_id: current_user.company_id)
    @demands=current_user.demands.with_legal_review_state
  end

  def create_copy
    @tmp=Draftagreement.find(params[:draftagreement_id])
    @agreement=Draftagreement.new
    @agreement.user_id=current_user.id
    @agreement.company_id=current_user.company_id
    @agreement.agreementtemplate_id=@tmp.agreementtemplate_id
    @agreement.demand_id=@tmp.demand_id
    @agreement.name=@tmp.name
    @agreement.save!

    for draftsection in @tmp.draftsections
      section=Draftsection.new
      section.draftagreement_id=@agreement.id
      section.name=draftsection.name
      section.user_id=current_user.id
      section.company_id=current_user.company_id
      section.save!
      for draftterm in draftsection.draftterms
        term=Draftterm.new
        term.draftagreement_id=@agreement.id
        term.draftsection_id=section.id
        term.user_id=current_user.id
        term.company_id=current_user.company_id
        term.content=draftterm.content
        term.save!
      end
    end
    @agreement.create_copy!
    redirect_to @agreement
  end

  def create
    @draftagreement=Draftagreement.new
    @draftagreement.name=draftagreement_params[:name]
    #@draftagreement.purchaser_company_id=Company.find_by_name(draftagreement_params[:purchaser_company]).id
    #@draftagreement.vendor_company_id=Company.find_by_name(draftagreement_params[:vendor_company]).id
    @draftagreement.user_id=current_user.id
    @draftagreement.company_id=current_user.company_id
    @draftagreement.demand_id=draftagreement_params[:demand_id]
    @draftagreement.agreementtemplate_id=draftagreement_params[:agreementtemplate_id]
    @draftagreement.order_no=0
    @draftagreement.save
    @draftagreement.submit_for_legal!
    Demand.find(@draftagreement.demand_id).submit_for_agreement!
    redirect_to @draftagreement, notice: "Sözleşme taslağı yaratıldı."
  end

  def show
    @draftagreement=Draftagreement.find(params[:id])
    case @draftagreement.current_state.name
      when :legal_writing
        if current_user.legal?
          @draftsection=Draftsection.new
          @draftterm=Draftterm.new
          @sectiontemplates=Sectiontemplate.where(company_id: current_user.company_id)
          @templates=Termtemplate.where(company_id: current_user.company_id)
          #Notice.inform(current_user.id,"Sözleşme üzerinde çalışılmaya başlandı.",1,draftagreement_path(@draftagreement))
        else
          redirect_to draftagreements_path, notice: "Hukuk birimi sözleşme taslağını henüz tamamlamadı."
          return
        end
      when :getting_feedback
        #Notice.inform(current_user.id,"Sözleşme hakkında sizden yorum bekleniyor.",2,draftagreement_path(@draftagreement))
        redirect_to draftagreement_feedback_path(@draftagreement), notice: "Sözleşme taslağı tamamlandı. Lütfen yorumlarınızı girin."
        return
      when :setting_access
        if current_user.user?
          redirect_to draftagreement_setting_access_path(@draftagreement), notice: "Sözleşmeyi paylaşacağınız kişilerin emaillarını girin."
          return
        else
          redirect_to draftagreements_path, notice: "İş birimi sözleşme üzerinde çalışacakları tanımlıyor."
          return
        end
      when :accepted
        redirect_to agreement_path(@draftagreement)
        return
    end
  end

  def setting_access
    @draftagreement=Draftagreement.find(params[:draftagreement_id])
    @companies=Company.all
    @draftcomment=Comment.new
    @agreement=Agreement.new
  end

  def feedback
    @draftagreement=Draftagreement.find(params[:draftagreement_id])
    @comment = Comment.new
  end

  def updatestatus
    @draftagreement=Draftagreement.find(params[:draftagreement_id])
    demand=Demand.find(@draftagreement.demand_id)
    case @draftagreement.current_state.name
      when :legal_writing
        @draftagreement.submit_for_feedback!
        demand.submit_for_feedback!
      when :getting_feedback
        @draftagreement.set_access_rights!
        demand.accept!
    end
    if params[:back]=="legal"
      @draftagreement.submit_for_feedback!
      demand.submit_for_feedback!
    end
    @draftagreement.save
    demand.save
    redirect_to draftagreement_path(@draftagreement), notice: "Taslak sözleşmenin durumu güncellenmiştir."
  end

  def add_note
    @draftagreement=Draftagreement.find(params[:draftagreement_id])
    @note=Draftnote.new
    @note.draftagreement_id=@draftagreement.id
    @note.user_id=current_user.id
    @note.content=params[:content]
    @note.save
    render json: @note
  end

  def get_note
    @note=Draftnote.find(params[:draftagreement_id])
    render json: @note
  end

  def draftagreement_params
    params.require(:draftagreement).permit(:name, :emails, :purchaser_company, :vendor_company, :agreementtemplate_id, :demand_id)
  end
end
