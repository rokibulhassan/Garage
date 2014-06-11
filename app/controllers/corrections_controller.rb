# for version properties
class CorrectionsController < ApplicationController
  before_filter :get_version_property, :only => [:index]

  def index
    if @version_property.version.user == current_user
      @corrections = @version_property.corrections
    else
      @corrections = @version_property.corrections.by_user(current_user)
    end
  end

  def create
    corrector_id = current_user.id
    version_prop_id = params[:version_property_id]
    @correction = Correction.where(:version_property_id => version_prop_id, :corrector_id => corrector_id).first_or_initialize
    @correction.value = params[:value]
    if version_prop_id.present? && version_prop_id != 'undefined' && @correction.save
      render :show, :status => 201
    else
      render :json => {}, :status => 500
    end
  end

  # accept/reject the correction
  # only owner of data can update the corrections
  def update
    @correction = Correction.find(params[:id])
    if params[:accept] && @correction.accept!
      render :json => { :accepted => true }, :status => 200
    elsif @correction.reject!
      render :json => { :rejected => true }, :status => 200
    else
      render :json => { :error => true }, :status => 500
    end
  end

  protected

  def get_version_property
    if (id = params[:version_property_id])
      @version_property = VersionProperty.find_by_id(id)
    end
    if @version_property.blank?
      render :json => {}, :status => 400
    end
  end
end
