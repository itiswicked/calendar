class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      name = auth.info.name.split(" ")
      user.first_name = name[0]
      user.last_name = name[1]
      user.provider = provider
      user.uid = uid
      user.email = auth.info.email || ""
      user.username = auth.info.nickname
    end
  end

  def identifier
    return first_name unless first_name.nil? || first_name.empty?
    return username unless username.nil? || username.empty?
    return email unless email.nil? || email.empty?
    "User"
  end

  def self.catagories_for_dropdown
    all.map { |user| [user.name. user.id] }
  end
end
