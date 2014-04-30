class Video < ActiveRecord::Base

  validates :url, presence: { message: "URL cannot be blank" }

  def print_youtube_id
    self.url.split('=').last
  end
end