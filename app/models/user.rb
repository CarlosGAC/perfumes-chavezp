class User < ApplicationRecord
  
  # Devise module definition and authentication key changed to username
  devise :database_authenticatable, :registerable,
        :validatable, :authentication_keys => [:username]
  
  # Validates that username and email are unique
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
  
end