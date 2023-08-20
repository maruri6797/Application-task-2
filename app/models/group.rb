class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_one_attached :image

  validates :name, presence: :true
  validates :introduction, presence: :true, length: { maximum: 50 }

  def is_owned_by?(user)
    owner_id == user.id
  end
end
