class User < ApplicationRecord
  
  # Devise module definition and authentication key changed to username
  devise :database_authenticatable, :registerable,
        :validatable, :authentication_keys => [:username]
  
  # Validates that username and email are unique
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  
  # Overrides two methods to state that saving an email field it's not necessary
  # to save an user
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
  
end