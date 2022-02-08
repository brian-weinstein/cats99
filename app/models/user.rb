# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :text             not null
#  password_digest :text             not null
#  session_token   :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    attr_reader :password

    validates :user_name, :session_token, presence: true
    validates :password_digest, presence: {message: "Password can't be blank"}
    validates :user_name, :session_token, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    after_initialize :ensure_session_token

    has_many :cats

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pw = BCrypt::Password.new(self.password_digest)
        pw.is_password?(password)
    end

    def self.find_by_credentials(username,password)
        user = User.find_by(user_name: username)
        return nil unless user
        user.is_password?(password) ? user : nil
    end

    def generate_session_token
        self.session_token = SecureRandom::urlsafe_base64(16)
    end
    
    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save!
        self.session_token
    end

    def owns_cat?(cat)
        cat.user_id == self.id
    end

    private
    def ensure_session_token
        self.session_token ||= generate_session_token
    end
end
