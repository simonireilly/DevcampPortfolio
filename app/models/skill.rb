class Skill < ApplicationRecord
  include Placeholder
  validates_presence_of :title, :percent_utilized

  after_initialize :set_defaults
  def set_defaults
    self.badge ||=  Placeholder.image_generator(height: '200', width: '350')
  end
end
