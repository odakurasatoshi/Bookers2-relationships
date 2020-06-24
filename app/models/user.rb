class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :books, dependent: :destroy

    has_many :relationships
    #中間テーブルはrelationships #relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセス
    has_many :followings, through: :relationships, source: :follow
    #has_many :relaitonshipsの「逆方向」#relaitonshipsテーブルにアクセスする時、follow_idが入口
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
    #中間テーブルはreverses_of_relationshipにしてね」と設定 #出口はuser_idね！それでuserテーブルから自分をフォローしているuserをとってきてね！
    has_many :followers, through: :reverse_of_relationships, source: :user
    attachment :profile_image
  validates :name, presence: true, length: {minimum:2, maximum:20}
  validates :introduction, length:{maximum:50}

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
