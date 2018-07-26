class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :post_content, :presence => true
  validates :post_owner, :presence => true, :length => { :minimum => 5 }
end
