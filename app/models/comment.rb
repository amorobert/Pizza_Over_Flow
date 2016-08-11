class Comment < ActiveRecord::Base
  include PostInfo

  validates :content, presence: true

  belongs_to :commentable, :polymorphic => true
  belongs_to :commenter, class_name: 'User'

  def vote_count
    votes = self.votes.pluck("value")
    if votes.empty?
      0
    else
      votes.reduce(:+)
    end
  end

  def age
    distance_of_time_in_words(self.created_at, Time.now)
  end

end
