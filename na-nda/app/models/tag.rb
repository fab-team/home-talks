class Tag < ApplicationRecord
	validates :name,presence:true,length:{maximum:50}
	has_many :entry, through: :entry_tags
	has_many :entry_tags, dependent: :destroy
end
