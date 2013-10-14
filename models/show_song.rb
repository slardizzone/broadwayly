class Song < ActiveRecord::Base
	belongs_to :show
end

class Show < ActiveRecord::Base
	has_many :songs

	validates :title, presence: true
	validates :title, uniqueness: true
end

