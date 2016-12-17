class User < ApplicationRecord
	validates :uname, presence: true, length: { maximum: 15 },uniqueness: true
	validates :pwdkey, presence: true, 	length: { maximum: 15 }
end
