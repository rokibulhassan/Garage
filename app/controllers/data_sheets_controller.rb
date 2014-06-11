class DataSheetsController < ApplicationController
  load_resource :version, only: :show
  load_resource :model, only: :index

  def show
    @data_sheet_props = @version.data_sheet_props
  end

  def index
    @vehicles = Vehicle.approved.with_model(@model)
  end

end