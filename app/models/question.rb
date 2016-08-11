class Question < ActiveRecord::Base
  include PostInfo

  validates :title, :content, presence: true

  belongs_to :asker, class_name: 'User'
  has_many :answers
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable

  def answer_count
    self.answers.count
  end
end
