class Group < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :posts
  has_many :members, through: :memberships, source: :user
  validates :name, presence: true

end
