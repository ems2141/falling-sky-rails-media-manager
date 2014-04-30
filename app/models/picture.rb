class Picture < ActiveRecord::Base
  validates :url, presence: { message: "cannot be blank" }
  validates :description, presence: { message: "cannot be blank" }
end