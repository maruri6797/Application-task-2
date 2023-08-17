class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true,length:{maximum:200}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
  scope :created_last_week, -> { where(created_at: Time.current.last_week.all_week) }
  scope :created_this_week, -> { where(created_at: Time.current.all_week) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partical_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end
