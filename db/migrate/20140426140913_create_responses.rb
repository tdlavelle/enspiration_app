class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :content
      t.integer :question_id

      t.timestamps
    end
    add_index :responses, [:question_id, :created_at]
  end
end
