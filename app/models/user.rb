class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :email, :name, :password, presence: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  # validate :password_is_longer_than_eight_characters

  has_many :comments, foreign_key: :commenter_id
  has_many :questions,  foreign_key: :asker_id
  has_many :answers, foreign_key: :answerer_id
  has_many :votes, foreign_key: :voter_id

  def create(params = {}) #is this method necessary?
    @user = User.new(name: params[:name], email: params[:email])
    @user.password = params[:password]
    @user.save!
  end

  def self.authenticate(email, password)
    logging_user = User.find_by(email: email)
    if logging_user && logging_user.password == password
      return logging_user
    end
    nil
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    #@plain_text = new_password
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  #FOR SOME REASON THIS WASN'T WORKING
  # def password_is_longer_than_eight_characters
  #   errors.add(:password, "must be longer than eight (8) characters") unless @plaintext && @plaintext.length > 8
  # end
end
