class Vote < ActiveRecord::Base
  validates :votable_type, presence: true

  belongs_to :votable, :polymorphic => true
  belongs_to :voter, class_name: 'User'

end
