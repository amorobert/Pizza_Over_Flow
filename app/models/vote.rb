class Vote < ActiveRecord::Base
  validates :votable, presence: true

  belongs_to :votable, :polymorphic => true
  belongs_to :voter, class_name: 'User'

end
