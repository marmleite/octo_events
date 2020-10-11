class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :guid, null: false
      t.jsonb :payload, null: false, default: '{}'

      t.timestamps
    end
  end
end
