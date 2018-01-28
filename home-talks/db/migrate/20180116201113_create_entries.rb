class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :user, null: false               # 外部キー
      t.string :title, null: false                    # タイトル
      t.text :body                                    # 本文
      t.datetime :posted_at, null: false              # 投稿日
      t.string :status, null: false, default: "public" # 状態

      t.timestamps null: false
    end

    # add_index :entries, :member_id
  end
end
