class CreatePerfumes < ActiveRecord::Migration[5.1]
  def change
    create_table :perfumes do |t|

      t.string :name
      # TODO: Agregar campo para casa de perfume
      t.float :buy_price
      t.float :retail_price
      t.integer :stock
      t.integer :public_target
      t.integer :classification
      t.integer :category
      t.integer :presentation
      t.integer :visibility
      t.timestamps
    end
  end
end
