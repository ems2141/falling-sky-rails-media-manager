class Video < ActiveRecord::Base

  validates :url, presence: {message: "URL cannot be blank"}
  validates :url, format: {
    with: URI::regexp(['https', 'http']),
    message: "URL must be valid",

  }

  validates :rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0,
    message: "Rating must be between 0 and 5"
  }

  validates :description, presence: {message: "Description cannot be blank"}

  def print_youtube_id
    self.url.split('=').last
  end
end