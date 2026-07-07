class Group < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :nullify

  validates :name, presence: true
end
