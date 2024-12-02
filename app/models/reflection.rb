class Reflection < ApplicationRecord
  belongs_to :use
  scope :default_order, -> { order(:id) }
end
