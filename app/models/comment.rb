class Comment < ActiveRecord::Base
  attr_accessible :text

	include CommentPermission

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :text, :presence => true
  default_scope :order => 'created_at'
end