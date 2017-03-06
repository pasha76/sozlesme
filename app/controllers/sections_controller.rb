class SectionsController < ApplicationController

  def update
    section=Section.find(params[:id])
    section.update_attributes(params[:name] => params[:value])
    render json: section
  end
end
