module Listings
  class Reviews < BaseService
    def initialize(params)
      super
      @listing = @params[:listing]
    end

    def call
      # @TODO cache the metrics below and refresh them each day after we've got new reviews
      # @TODO words rendering will have performance issues when the listing has a large number of reviews
      @metrics = { month: {}, year: {} }
      @words = {}
      @listing.reviews.order(created_at: :asc).each do |review|
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

      {
        metrics: @metrics,
        words: @words
      }
    end
  end
end
