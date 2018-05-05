class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.float :amount
      t.date :payment_date
      t.belongs_to :bill, index: true
      t.timestamps
    end
  end
end
