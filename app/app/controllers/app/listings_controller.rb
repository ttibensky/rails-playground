require 'rest-client'

module App
  class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
      # @TODO move logic to a service
      @listings = Listing.where(user: current_user).order(created_at: :desc)
    end

    def show
      # @TODO move logic to a service
      @listing = Listing.find_by(id: params[:id], user: current_user)

      # @TODO cache the metrics below and refresh them each day after we've got new reviews
      # @TODO words rendering will have performance issues when the listing has a large number of reviews
      @metrics = { month: {}, year: {} }
      @words = {}
      (@listing.reviews.order(created_at: :asc) || []).each do |review|
        month = review.created_at.strftime('%Y-%m')
        year = review.created_at.strftime('%Y')

        @metrics[:month].merge!({ month => 0 }) unless @metrics[:month][month].present?
        @metrics[:year].merge!({ year => 0 }) unless @metrics[:year][year].present?

        @metrics[:month][month] += 1
        @metrics[:year][year] += 1

        review.text.split.each do |word|
          next unless word.length > 3

          @words[word] = [word, 0] unless @words.key?(word)
          @words[word][1] += 1
        end
      end
      @words = @words.values
    end

    def create
      # @TODO move logic to a service
      listing = Listing.new
      listing.title = 'Cool listing title TODO' # @TODO modify crawler to also return the listing title
      listing.url = params[:listing][:url]
      listing.user = current_user
      listing.save!

      # @TODO move logic to a sidekiq job
      response = RestClient.post 'http://crawler:3000/reviews/airbnb', { url: listing.url }.to_json, { content_type: :json, accept: :json }
      JSON.parse(response).each do |raw_review|
        review = Review.new
        review.listing = listing
        review.author = raw_review['author']
        review.text = raw_review['text']
        review.stars = raw_review['stars']

        date = raw_review['date']
        created_at = DateTime.now
        if date.match(/day/)
          created_at -= date.scan(/^\d+/).first.to_i.days
        elsif date.match(/week/)
          created_at -= date.scan(/^\d+/).first.to_i.weeks
        elsif date.match(/month/)
          created_at -= date.scan(/^\d+/).first.to_i.months
        else
          parsed_date = DateTime.parse(date)
          created_at = parsed_date if !!parsed_date
        end
        review.created_at = created_at

        review.save!
      end

      redirect_to app_listings_show_path(id: listing.id)
    end
  end
end
