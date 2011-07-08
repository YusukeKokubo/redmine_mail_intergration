class AddUsername < ActiveRecord::Migration
  def self.up
    add_column(:mail_messages, "username", :string, :null => false)
  end

  def self.down
    remove_column(:mail_messages, "username")
  end
end

