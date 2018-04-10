class Blog < ApplicationRecord
  belongs_to :topic
  accepts_nested_attributes_for :topic
  has_many :comments, dependent: :destroy

  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: [:slugged]
  validates_presence_of :title, :body

  default_scope { order('created_at DESC') }
end
