class Listing < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  # @TODO add URL validation
end
