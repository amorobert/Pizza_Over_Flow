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
end
