class Visit < ActiveRecord::Base
	scope :today, -> { where(:created_at => (Time.now.beginning_of_day..Time.now.end_of_day)) }
	belongs_to :store
	belongs_to :customer, class_name: "User"

	before_validation(on: :create) { match_daily_code }
	before_validation(on: :create) { time_daily_code }

	validates_presence_of :store_id, :customer_id, :near_location, :check_in_code

	validates :near_location,
		:inclusion => { :in => [true],
		:message => "visit must be near store location!" }

	# validate :match_daily_code, on: :save

	private

	def match_daily_code
		errors.add(:check_in_code, "Does not match daily code!") unless self.check_in_code == self.store.daily_code
	end

	def time_daily_code
		errors.add(:must_wait, "Cannot check in more than once a day!") if Visit.created_today?(self.store_id, self.customer_id)
	end

	def Visit.created_today?(store_id, customer_id)
		Visit.today.where("store_id = ? AND customer_id = ?", store_id, customer_id).any?
	end


end
