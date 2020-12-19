class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :profile_image
  validates :name, presence: true ,length: {in:2..20}, uniqueness: true
  validates :introduction ,length: {maximum: 50}

  has_many :follower_relationships,foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :followed_relationships,foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followeds, through: :followed_relationships

  def followed?(other_user)
    self.followeds.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    self.followed_relationships.create(followed_id: other_user.id)
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.followed_relationships.find_by(followed_id: other_user.id).destroy
  end

end
