class Visit < ActiveRecord::Base
	belongs_to :store
	belongs_to :customer, class_name: "User"
end
