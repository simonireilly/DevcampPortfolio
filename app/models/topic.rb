class Topic < ApplicationRecord
  has_many :blogs
  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 2, maximum: 25 }
end
