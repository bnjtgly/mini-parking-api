class Entity < ApplicationRecord
  has_many :sub_entities
  before_save :titleize
  before_update :titleize

  def titleize
    self.entity_name = entity_name.try(:downcase).try(:titleize)
  end
end
