class Entry < ApplicationRecord
	belongs_to :author, class_name: "User", foreign_key: "user_id"
  acts_as_taggable_on :sex, :job
  acts_as_taggable

	# バリデージョン
  STATUS_VALUES = %w(public draft)

  validates :title, presence: true, length: { maximum: 200 }
  validates :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }
  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?", "draft") }
  scope :full, ->(user) {
    where("user_id = ? OR status <> ?", user.id, "draft")
  }
  scope :readable_for, ->(user) { user ? full(user) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end

    def sidebar_entries(member, num = 5)
      readable_for(member).order(posted_at: :desc).limit(num)
    end
  end

end
