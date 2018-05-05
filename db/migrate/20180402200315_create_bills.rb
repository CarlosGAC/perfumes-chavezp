class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.date :bill_date
      t.belongs_to :client, index: true
      t.integer :amount
      t.float :total
      t.integer :status
      t.references :perfume, foreign_key: true, index: true
      t.timestamps
    end
  end
end
