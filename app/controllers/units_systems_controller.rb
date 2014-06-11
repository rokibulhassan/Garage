class UnitsSystemsController < ApplicationController
  def index
    @systems = UnitSystem.all
  end
end
