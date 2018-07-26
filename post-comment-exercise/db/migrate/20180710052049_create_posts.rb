class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :post_content
      t.string :post_owner

      t.timestamps
    end
  end
end
