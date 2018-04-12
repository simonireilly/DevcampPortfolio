class Skill < ApplicationRecord
  validates_presence_of :title, :percent_utilized

  default_scope { order('title ASC') }
end
