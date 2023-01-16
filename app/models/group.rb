class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates_uniqueness_of :name
  validates :name, presence: true
end
