class AddListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title, null: true
      t.string :url, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    create_table :reviews do |t|
      t.string :text, null: true
      t.integer :stars, null: false
      t.string :author, null: false
      t.integer :listing_id, null: false
      t.timestamps
    end

    add_foreign_key :listings, :users
    add_foreign_key :reviews, :listings
  end
end
