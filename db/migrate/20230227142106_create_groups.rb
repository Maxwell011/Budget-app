class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
            t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :name
      t.timestamps
    end
  end
end
