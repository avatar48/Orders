class CreateFilesIns < ActiveRecord::Migration[5.0]
  def change
    create_table :files_ins do |t|
      t.string :name

      t.timestamps
    end
  end
end
