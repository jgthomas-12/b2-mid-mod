class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.integer :age

      t.timestamps
    end
  end
end
