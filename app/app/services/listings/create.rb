module Listings
  class Create < BaseService
    def initialize(params)
      super
      @url = @params[:url]
      @current_user = @params[:current_user]
    end

    def call
      listing = Listing.new
      listing.title = 'Cool listing title TODO' # @TODO modify crawler to also return the listing title
      listing.url = @url
      listing.user = @current_user
      listing.save!

      FetchReviewsFromAirbnbJob.perform_async(listing.id)

      listing
    end
  end
end
