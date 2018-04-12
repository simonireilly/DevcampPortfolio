class Topic < ApplicationRecord
  has_many :blogs
  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 2, maximum: 25 }
  def self.with_blogs
    includes(:blogs).where.not(blogs: {id: nil, status: 'draft'})
  end
end
