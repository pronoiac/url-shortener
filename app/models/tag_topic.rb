class TagTopic < ActiveRecord::Base
  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )
  
  has_many(
    :urls,
    through: :taggings,
    source: :url
  )
  
  def most_popular_url
    urls.group("shortened_urls.id").order("COUNT (shortened_urls.id) DESC").first    
  end
end