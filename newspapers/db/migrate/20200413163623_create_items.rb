class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :filename
      t.string :publication
      t.string :location
      t.date :date
      t.integer :page
      t.string :url

      t.timestamps
    end
  end
end
