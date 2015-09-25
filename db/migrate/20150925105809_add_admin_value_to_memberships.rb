class AddAdminValueToMemberships < ActiveRecord::Migration
  def change

    def up
      add_column :memberships, :admin, :boolean, :default => :true
      remove_column :memberships, :is_admin
    end
end
