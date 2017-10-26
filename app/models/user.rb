class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.load_from_token(token)
    payload = JWT.decode(token, ENV.fetch("USER_PAYLOAD_TOKEN"), false)[0]
    self.find(payload.fetch("id"))
  rescue JWT::DecodeError
    raise ActiveRecord::RecordNotFound
  end

  def get_auth_token
    JWT.encode({ id: self.id }, ENV.fetch("USER_PAYLOAD_TOKEN"), 'none')
  end
end
