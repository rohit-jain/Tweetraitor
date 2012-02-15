class CreateGuestVoteRecords < ActiveRecord::Migration
  def change
    create_table :guest_vote_records do |t|
      t.references :guest
      t.integer :vote
      t.string :category
      t.integer :tid

      t.timestamps
    end
    add_index :guest_vote_records, :guest_id
  end
end
