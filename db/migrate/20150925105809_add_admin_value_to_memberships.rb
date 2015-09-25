class AddAdminValueToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :admin, :boolean, :default => :false
    remove_column :memberships, :is_admin, :boolean
  end
end
