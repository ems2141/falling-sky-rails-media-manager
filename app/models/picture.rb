class Picture < ActiveRecord::Base
  validates :url, presence: { message: "cannot be blank" }
  validates :url, format: { with: URI::regexp(['http', 'https']), message: "Enter a valid URL" }
  validates :description, presence: { message: "cannot be blank" }
end