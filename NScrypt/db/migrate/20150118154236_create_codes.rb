class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :version
      t.text :code
      t.references :contract, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :codes, :contracts
  end
end
