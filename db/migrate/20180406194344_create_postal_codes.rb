class CreatePostalCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :postal_codes do |t|
      t.integer :c_postal
      t.string :settlement
      t.string :settlement_type
      t.string :township
      t.string :state
      t.string :city
    end
  end
end
