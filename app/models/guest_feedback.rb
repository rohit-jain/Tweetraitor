class GuestFeedback < ActiveRecord::Base
  belongs_to :guest
  validates_presence_of :content, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
