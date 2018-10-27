class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://goo.gl/maps/nBAxNAsmPSS2'
    @cool_earth_url = 'https://www.coolearth.org/'
  end
end
