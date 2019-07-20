class User < ApplicationRecord

    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
    
    
    has_secure_password
    
    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

end
