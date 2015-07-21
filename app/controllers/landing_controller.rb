require 'open-uri'

class LandingController < ApplicationController
  def landing


    render("home.html.erb")
  end
end
