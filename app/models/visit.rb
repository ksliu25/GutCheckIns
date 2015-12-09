class Visit < ActiveRecord::Base
	belongs_to :store
	belongs_to :customer, class_name: "User"

	before_validation(on: :create) { match_daily_code }

	validates_presence_of :store_id, :customer_id, :near_location, :check_in_code

	validates :near_location,
		:inclusion => { :in => [true],
		:message => "visit must be near store location!" }

	# validate :match_daily_code, on: :save

	private

	def match_daily_code
		errors.add(:check_in_code, "Does not match daily code!") unless self.check_in_code == self.store.daily_code
	end


end
