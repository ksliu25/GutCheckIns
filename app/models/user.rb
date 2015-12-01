class User < ActiveRecord::Base
	has_many :stores, foreign_key: "owner_id"
	has_many :visits, foreign_key: "customer_id"
end
