class Video < ActiveRecord::Base


  def print_youtube_id
    self.url.split('=').last
  end
end