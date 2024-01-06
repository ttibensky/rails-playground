module App
  class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
      @listings = Listing.where(user: current_user).order(created_at: :desc)
    end

    def show
      @listing = Listing.find_by(id: params[:id], user: current_user)

      # @TODO cache the metrics below and refresh them each day after we've got new reviews
      @metrics = { month: {}, year: {} }
      (@listing.reviews || []).each do |review|
        month = review.created_at.strftime('%Y-%m')
        year = review.created_at.strftime('%Y')

        @metrics[:month] = { month => 0 } unless @metrics[:month][month].present?
        @metrics[:year] = { year => 0 } unless @metrics[:year][year].present?

        @metrics[:month][month] += 1
        @metrics[:year][year] += 1
      end

      @chart_data = {
        labels: %w[January February March April May June July],
        datasets: [{
          label: 'My First dataset',
          backgroundColor: 'transparent',
          borderColor: '#3B82F6',
          data: [37, 83, 78, 54, 12, 5, 99]
        }]
      }
  
      @chart_options = {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    end
  end
end
