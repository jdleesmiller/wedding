# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://g.page/LolomaLodge?share'
    @cool_earth_url = 'https://www.coolearth.org/'
  end
end
