class CreateVoteRecords < ActiveRecord::Migration
  def change
    create_table :vote_records do |t|
      t.references :tweeple
      t.integer :vote
      t.string :category
      t.integer :tid

      t.timestamps
    end
    add_index :vote_records, :tweeple_id
  end
end
