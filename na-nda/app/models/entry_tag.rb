class EntryTag < ApplicationRecord
  belongs_to :entry
  belongs_to :tag
  validates :entry_id,presence:true
  validates :tag_id,presence:true
end
