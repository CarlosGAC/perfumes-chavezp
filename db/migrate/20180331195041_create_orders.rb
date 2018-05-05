class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|

      t.integer :amount
      t.integer :status
      t.float :total
      t.belongs_to :order_datum, index: true
      t.references :perfume, foreign_key: true, index: true
      t.timestamps
    end
  end
end
