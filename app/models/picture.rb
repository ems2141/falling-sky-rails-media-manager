class Picture < ActiveRecord::Base
  validates :url, presence: { message: "URL cannot be blank" }
  validates :description, presence: { message: "Description cannot be blank" }
end