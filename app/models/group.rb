class Group < ApplicationRecord
  validates :name, presence: true
  has_many :affiliated_group, dependent: :destroy
end
