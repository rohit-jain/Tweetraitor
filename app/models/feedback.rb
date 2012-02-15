class Feedback < ActiveRecord::Base
  belongs_to :tweeple  
  #validates :content, :presence => true
end
