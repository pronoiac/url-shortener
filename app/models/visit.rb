class Visit < ActiveRecord::Base
  validates :visitor, presence: true
  validates :shortened_url, presence: true
  
  def self.record_visit!(user, shortened_url)
    Visit.create!(
      :visitor_id => user.id, 
      :url_id => shortened_url.id)
  end
  
  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :visitor_id, 
    primary_key: :id
  )
  
  belongs_to(
    :shortened_url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
  )
end