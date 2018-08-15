class User < ActiveRecord::Base
    has_many :videos, :dependent => :destroy
    validates_uniqueness_of :username
    validates_uniqueness_of :email
end 