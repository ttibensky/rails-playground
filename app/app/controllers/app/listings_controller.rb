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
      @words = {}
      (@listing.reviews || []).each do |review|
        month = review.created_at.strftime('%Y-%m')
        year = review.created_at.strftime('%Y')

        @metrics[:month] = { month => 0 } unless @metrics[:month][month].present?
        @metrics[:year] = { year => 0 } unless @metrics[:year][year].present?

        @metrics[:month][month] += 1
        @metrics[:year][year] += 1

        review.text.split do |word|
          next unless word.length > 3

          @words[word] = [word, 0] unless @words.key?(word)
          @words[word][1] += 1
        end
      end
      @words = @words.values
    end
  end
end
