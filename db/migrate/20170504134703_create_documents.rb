class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :number
      t.date :date
      t.decimal :sum, precision: 8, scale: 2
      t.integer :inn , :limit => 10

      t.timestamps
    end
  end
end
