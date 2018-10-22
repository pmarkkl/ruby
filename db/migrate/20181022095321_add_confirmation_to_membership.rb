class AddConfirmationToMembership < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :confirmed, :boolean, :default => false
  end
end

Membership.each do |m|
  m.confirmed = true
  m.save
end