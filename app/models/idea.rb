class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :nullify

  validates :title, presence: true
  validates :body, presence: true
end
