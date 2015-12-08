class Visit < ActiveRecord::Base
	belongs_to :store
	belongs_to :customer, class_name: "User"


	validates_presence_of :store_id, :customer_id, :near_location, :check_in_code
	
	validates :near_location,
		:inclusion => { :in => [true],
		:message => "visit must be near store location!" }

	validate :match_daily_code, on: :create

	def match_daily_code
		@store = Store.find(self.store_id)
		errors.add(:check_in_code, "Does not match daily code!") unless self.check_in_code == @store.daily_code
	end


end
