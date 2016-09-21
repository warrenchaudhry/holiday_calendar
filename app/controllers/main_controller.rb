class MainController < ApplicationController

  def index
    params[:regions] = "ph"
  end

  def events
    params[:start] ||= Time.zone.now.to_date.beginning_of_month
    params[:end] ||= Time.zone.now.to_date.end_of_month
    holidays = Holidays.between(params[:start].to_date, params[:end].to_date, region_params)
    events = []
    holidays.each do |holiday|
      region = holiday[:regions][0]
      country = ISO3166::Country[region].name
      events << {start: holiday[:date], title: holiday[:name], country: country, description: "This holiday is on country #{country}"}
    end
    render json: events
  end

  def region_params
    regions = params[:regions].present? ? params[:regions] : 'ph'
    valid_regions = available_regions.collect(&:last) & (regions.is_a?(String) ? [regions] : regions)
    return ['ph'] if valid_regions.empty?
    valid_regions
  end

end
