class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments
  validates :title, presence: true
  validates :content, presence: true

  # scope :no_group, -> { where(group_id: nil) }
end
