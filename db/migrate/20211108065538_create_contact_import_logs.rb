class CreateContactImportLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_import_logs do |t|
      t.string :row
      t.string :failure

      t.timestamps
    end
  end
end
