class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :list, through: :bookmarks
  validates :title, uniqueness: true
  validates :title, presence: true
  validates :overview, presence: true
end
