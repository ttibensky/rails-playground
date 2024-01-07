class FetchReviewsFromAirbnbJob
  include Sidekiq::Job

  def perform(listing_id)
    listing = Listing.find(listing_id)
    # @TODO move the crawler host and port to configuration
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
  end
end
