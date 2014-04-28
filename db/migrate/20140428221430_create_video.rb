class CreateVideo < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :description
      t.integer :rating
    end
  end
end
