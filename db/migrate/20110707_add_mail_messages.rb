class AddMailMessages < ActiveRecord::Migration
  def self.up
    create_table :mail_messages do |t|
      t.column :message_id, :string, :null => false
      t.column :issue_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_messages
  end
end

