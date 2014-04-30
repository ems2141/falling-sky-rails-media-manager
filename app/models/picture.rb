class Picture < ActiveRecord::Base
  validates :url, presence: { message: "URL cannot be blank" }
end