class CommentsController < ApplicationController
  before_filter :load_commentable


  def create
    commentable = Draftterm.find(get_params[:draftterm_id]) if not get_params[:draftterm_id].nil?
    commentable = Term.find(get_params[:term_id]) if not get_params[:term_id].nil?
    commentable = Question.find(get_params[:question_id]) if not get_params[:question_id].nil?
    comment = commentable.comments.create
    comment.comment = get_params[:comment]
    comment.role=current_user.role
    comment.user_id=current_user.id
    comment.save
    redirect_to draftagreement_feedback_path(Draftagreement.find(get_params[:draftagreement_id])) if not get_params[:draftterm_id].nil?
    redirect_to agreement_vendor_feedback_path(Agreement.find(commentable.agreement_id))  if not get_params[:term_id].nil?
    redirect_to "/questions/new?demand_id=#{get_params[:demand_id]}"  if not get_params[:question_id].nil?
  end

  protected
  def load_commentable
    @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  end

  private
  def get_params
    params.require(:comment).permit(:comment,:draftterm_id,:draftagreement_id,:term_id,:question_id,:demand_id)
  end
end
