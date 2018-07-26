class Comment < ApplicationRecord
  validates :comment_content, :presence => true
  validates :comment_owner, :presence => true
  belongs_to :post
end
