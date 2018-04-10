class Topic < ApplicationRecord
  has_many :blogs
  validates_presence_of :title, unique: true,
                        length: {minimum: 2, maximum: 25}
end
