require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    # First, get our coordinates...
    url="http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address + "&sensor=false"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    # Next, get our forecast...
    forecast_url = "https://api.forecast.io/forecast/c671ef54158ef77726b697e459bc200f/#{latitude},#{longitude}"
    fore_raw_data = open(forecast_url).read
    fore_parsed_data = JSON.parse(fore_raw_data)


    @current_temperature = fore_parsed_data["currently"]["temperature"]

    @current_summary = fore_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = fore_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = fore_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = fore_parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
