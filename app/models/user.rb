class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :announcements, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  roles = [ "pending", "member", "admin" ].freeze
  validates :role, inclusion: { in: roles }
  def admin?
    role == "admin"
  end
  def member?
    role == "member"
  end
  def pending?
    role == "pending"
  end
  def can_manage_events?
    admin? || member?
  end
end
