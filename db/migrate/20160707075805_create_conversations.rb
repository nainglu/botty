class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :chat
      t.string :respond
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
