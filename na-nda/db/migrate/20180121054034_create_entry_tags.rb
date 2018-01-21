class CreateEntryTags < ActiveRecord::Migration[5.1]
	def change
		create_table :entry_tags do |t|
			t.integer :entry_id
			t.integer :tag_id

			t.timestamps
		end
		add_index :entry_tags, :entry_id
		add_index :entry_tags, :tag_id
		add_index :entry_tags, [:entry_id,:tag_id],unique: true
	end
end
