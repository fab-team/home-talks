class Entry < ApplicationRecord
	belongs_to :author, class_name: "User", foreign_key: "user_id"


# # バリデージョン
 #  STATUS_VALUES = %w(draft user_only public)

 #  validates :title, presence: true, length: { maximum: 200 }
 #  validates :body, :posted_at, presence: true
 #  validates :status, inclusion: { in: STATUS_VALUES }

 scope :common, -> { where(status: "public") }
 scope :published, -> { where("status <> ?", "draft") }
 scope :full, ->(user) {
 	where("user_id = ? OR status <> ?", user.id, "draft") }
 	scope :readable_for, ->(user) { user ? full(user) : common }

 end
