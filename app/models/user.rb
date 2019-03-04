class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Assign an API key on create
  before_create do |user|
    user.apikey = user.generate_api_key
  end

  def get_apikey
    apikey
  end

  protected

    # Generate a unique API key
    def generate_api_key
      loop do
        token = SecureRandom.base64.tr('+/=', '')
        break token unless User.exists?(apikey: token)
      end
    end
end
