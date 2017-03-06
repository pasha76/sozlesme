class TermsController < ApplicationController
  before_action :authenticate_user!

  def add_comment
    commentable = Term.find(params[:term_id])
    comment = commentable.comments.create
    comment.comment = params[:content]
    comment.save
  end

  def update

    term=Term.find(params[:id])
    term.content=params[:content].gsub("<p></p>", "")
    term.save
    case params[:status]
      when "published"
        case term.agreement.current_state.to_s
          when "vendor_feedback"
            term.agreement.vendor_approve!
          when "vendor_approved"
            term.agreement.company_approve!
        end
        term.set_approved!
        render json: term
        return
      when "draft"
        case term.agreement.current_state.to_s
          when "vendor_feedback"
            term.agreement.vendor_draft!
          when "vendor_approved"
            term.agreement.company_draft!
        end
        term.set_draft!
        render json: term
    end



  end
end
