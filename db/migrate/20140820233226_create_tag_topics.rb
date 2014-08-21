class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string  :category
    
      t.timestamps
      
    end
    
    add_index :tag_topics, :category, unique: true
  end
end
