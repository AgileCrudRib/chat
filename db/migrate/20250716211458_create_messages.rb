class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
    end
  end
end