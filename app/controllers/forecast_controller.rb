require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    forecast_url = "https://api.forecast.io/forecast/c671ef54158ef77726b697e459bc200f/" + @lat +"," + @lng
    fore_raw_data = open(forecast_url).read
    fore_parsed_data = JSON.parse(fore_raw_data)

    @current_temperature = fore_parsed_data["currently"]["temperature"]

    @current_summary = fore_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = fore_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = fore_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = fore_parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
