class AgreementsController < ApplicationController


  def update
    agreement=Agreement.find(params[:id])
    agreement.update_attributes(params[:name]=> params[:value])

  end

  def index
    @agreements=current_user.agreements
  end

  def create

    user_emails=agreement_params[:emails].split(",")
    user_emails<<current_user.email unless agreement_params[:emails].include? current_user.email
    @users=User.where(["email in (?)", user_emails])
    @draftagreement=Draftagreement.find(agreement_params[:draftagreement_id])
    @agreement=Agreement.new
    @agreement.user_id=current_user.id

    @agreement.company_id=current_user.company_id
    @agreement.draftagreement_id=@draftagreement.id
    @agreement.agreementtemplate_id=@draftagreement.agreementtemplate_id
    @agreement.demand_id=@draftagreement.demand_id
    @agreement.name=@draftagreement.name
    @agreement.save!

    for draftsection in @draftagreement.draftsections
      section=@agreement.sections.new
      section.name=draftsection.name
      section.user_id=current_user.id
      section.save!
      for draftterm in draftsection.draftterms
        term=section.terms.new
        term.agreement_id=@agreement.id
        term.user_id=current_user.id
        term.company_id=current_user.company_id
        term.content=draftterm.content
        term.save!
      end
    end
    for user in @users
      user_agreement=@agreement.user_agreementaccesses.create(user: user)

      user_type=""
      if current_user.company_id==user.company_id or current_user.legal_company_id==user.company_id
        user_type="company"
      else
        user_type="vendor"
      end
      user_agreement.update_attributes(user_type: user_type)
    end
    @agreement.submit_to_vendor!
    @draftagreement.accept!
    redirect_to agreement_path(@agreement)
  end

  def show
    @agreement=Agreement.find(params[:id])
    if @agreement.users.include? current_user
      if @agreement.current_state<:approved
        redirect_to agreement_vendor_feedback_path(@agreement), notice: "Yorumlarınızı girebilirsiniz."
        return
      elsif @agreement.approved?
        redirect_to agreement_approved_path(@agreement), notice: "Sözleşmeniz finalize olmuştur."
        return
      elsif @agreement.final?
        redirect_to agreement_export_pdf_path(@agreement)
        return
      end
    else
      redirect_to root_path
    end


  end


  def approved
    @agreement=Agreement.find(params[:agreement_id])
  end

  def vendor_feedback
    @agreement=Agreement.find(params[:agreement_id])
    commentable = Draftterm.create
    @comment = commentable.comments.create
  end

  def export_pdf
    @agreement=Agreement.find(params[:agreement_id])

    respond_to do|format|
      format.pdf do
        render pdf: 'customer_print_out.pdf',
              # file: "#{Rails.root}/app/views/pdf/customer_print_out.pdf.erb",
               page_size: 'A4', encoding: 'UTF-8', :layout =>"pdf"
        #render :pdf => "report.pdf", :layout => "pdf",page_size: 'A4', encoding: 'UTF-8'
      end
    end

  end

  def add_note
    @agreement=Agreement.find(params[:agreement_id])
    @note=@agreement.notes.new
    @note.user_id=current_user.id
    @note.content=params[:content]
    @note.save
    render json: @note
  end

  def get_note
    @note=Note.find(params[:agreement_id])
    render json: @note
  end

  private

  def agreement_params
    params.require(:agreement).permit(:draftagreement_id, :emails)
  end


end
