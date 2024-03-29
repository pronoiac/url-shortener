class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :url_id
    
      t.timestamps
    end

    add_index :taggings, :tag_topic_id
    add_index :taggings, :url_id
  end
end
