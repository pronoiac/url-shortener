class Tagging < ActiveRecord::Base
  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )
  
  belongs_to(
    :tag_topic,
    class_name: 'TagTopic',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )
end