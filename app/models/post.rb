class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5}
  validates :user_id, presence: true
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  scope :revorder, order("created_at desc")
  scope :recent, order:"created_at desc", limit: 5
  
  
end
