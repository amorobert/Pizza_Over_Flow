module PostInfo
  include ActionView::Helpers::DateHelper

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
end
