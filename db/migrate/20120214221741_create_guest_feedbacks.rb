class CreateGuestFeedbacks < ActiveRecord::Migration
  def change
    create_table :guest_feedbacks do |t|
      t.references :guest
      t.string :email
      t.text :content

      t.timestamps
    end
    add_index :guest_feedbacks, :guest_id
  end
end
