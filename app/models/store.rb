class Store < ActiveRecord::Base
	belongs_to :owner, class_name: "User" 

	validates_presence_of :address, :latitude, :longitude, :daily_code, :owner_id

	before_validation(on: :create) do
		generate_new_daily_code if self.daily_code.nil?
	end

	def generate_new_daily_code
		self.daily_code = generate_4_digit_string
	end

	private

	def generate_4_digit_string
		string = ""
		4.times do
			string += ([0,1,2,3,4,5,6,7,8,9].sample).to_s
		end
		return string
	end


end
