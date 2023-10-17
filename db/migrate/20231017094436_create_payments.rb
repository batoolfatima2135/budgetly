class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.decimal :amount
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
