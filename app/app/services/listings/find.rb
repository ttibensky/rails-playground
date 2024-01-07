module Listings
  class Find < BaseService
    def initialize(params)
      super
      @id = @params[:id]
      @current_user = @params[:current_user]
    end

    def self.find_one_by_id(*args, &block)
      new(*args, &block).find_one_by_id
    end

    def self.find_all(*args, &block)
      new(*args, &block).find_all
    end

    def find_one_by_id
      Listing.find_by(id: @id, user: @current_user)
    end

    def find_all
      Listing.where(user: @current_user).order(created_at: :desc)
    end
  end
end
