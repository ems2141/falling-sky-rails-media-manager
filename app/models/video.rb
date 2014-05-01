class Video < ActiveRecord::Base

  validates :url, presence: { message: "URL cannot be blank" }
  validates :url, format: {
        with: URI::regexp(['https','http']),
        message: "URL must be valid"
  }

  def print_youtube_id
    self.url.split('=').last
  end
end