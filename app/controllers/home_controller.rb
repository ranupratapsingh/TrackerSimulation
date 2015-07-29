class HomeController < ApplicationController
  def index

  end

  def marker_positions
    change_positions
    sleep 2
    @positions = Rails.cache.read(:markers)
  end

  private
  def change_positions
    if Rails.cache.read(:markers)
      markers = Rails.cache.read(:markers)
      markers.each do |x|
        x[:y] += 0.001
      end
      Rails.cache.write :markers, markers
    else
      Rails.cache.write :markers, [
          {x: 28.602, y:77.375},
          {x: 28.603, y:77.376},
          {x: 28.604, y:77.377},
          {x: 28.605, y:77.378},
          {x: 28.606, y:77.379}
      ]
    end

  end
end
