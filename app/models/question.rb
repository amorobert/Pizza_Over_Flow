class Question < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  validates :title, :content, presence: true

  belongs_to :asker, class_name: 'User'
  has_many :answers
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable

  def age
    distance_of_time_in_words(self.created_at, Time.now)
  end

  def vote_count
    votes = self.votes.pluck("value")
    if votes.empty?
      0
    else
      votes.reduce(:+)
    end
  end

  def answer_count
    self.answers.count
  end
end
