class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :available_regions

  def available_regions
    @available_regions ||= Holidays.available_regions.sort.uniq.map{|r| ISO3166::Country[r] ? [ ISO3166::Country[r].name , r.to_s ] : nil }.compact.sort_by{|a| a[0]}
  end

end
