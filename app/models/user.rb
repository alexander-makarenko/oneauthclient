class User < ApplicationRecord

  def self.find_or_create_from_auth_hash(auth_hash)    
    find_or_initialize_by(auth_token: auth_hash['auth_token']).tap do |user|
      user.first_name = auth_hash['first_name']
      user.last_name = auth_hash['last_name']
      user.email = auth_hash['email']
      user.save!
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end