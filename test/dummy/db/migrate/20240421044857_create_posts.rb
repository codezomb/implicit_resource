class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts, primary_key: [:author_id, :slug] do |t|
      t.integer :author_id
      t.string  :slug,

      t.timestamps
    end
  end
end
