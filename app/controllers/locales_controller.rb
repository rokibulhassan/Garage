# encoding: utf-8
class LocalesController < ApplicationController
  def index
    @locales = locales
  end


  protected

  def locales
    {
      'fr' => 'Français',
      'en' => 'English'
    }
  end
end
