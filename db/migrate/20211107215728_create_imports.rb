class CreateImports < ActiveRecord::Migration[6.1]
  def change
    create_table :imports do |t|
      t.text :csv_content
      t.json :column_options, default: {}
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
