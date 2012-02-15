class CreateFootballs < ActiveRecord::Migration
  def change
    create_table :footballs do |t|
      t.string :tweetId
      t.integer :token1Id
      t.integer :token2Id
      t.integer :category
      t.string :tweetText
      t.string :tweetToken1
      t.string :tweetToken2
      t.integer :voteCat1 , :default=>0
      t.integer :voteCat2 , :default=>0
      t.integer :done , :default=>0

      t.timestamps
    end
  end
end
