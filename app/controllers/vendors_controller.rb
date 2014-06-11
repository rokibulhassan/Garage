class VendorsController < ApplicationController
  def create
    @vendor = Vendor.create!(params[:vendor])
  end


  def index
    @vendors = Vendor.all
  end
end
