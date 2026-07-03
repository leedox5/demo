class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :search, ->(query) {
    return all if query.blank?

    where("title LIKE ? OR body LIKE ?", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%")
  }

  def views_count_for_display
    views_count || 0
  end
end
