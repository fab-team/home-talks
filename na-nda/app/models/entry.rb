class Entry < ApplicationRecord
	belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags

	# バリデージョン
  STATUS_VALUES = %w(draft user_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

 scope :common, -> { where(status: "public") }
 scope :published, -> { where("status <> ?", "draft") }
 scope :full, ->(user) {
 	where("user_id = ? OR status <> ?", user.id, "draft") }
 	scope :readable_for, ->(user) { user ? full(user) : common }


  # タグ
  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      entry_tag = Tag.find_or_create_by(name:new_name)
      self.tags << entry_tag
    end
  end

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
