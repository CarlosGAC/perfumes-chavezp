class CreateOrderData < ActiveRecord::Migration[5.1]
  def change
    create_table :order_data do |t|
      t.date :order_date
      t.belongs_to :client, index: true
      t.timestamps
    end
  end
end
