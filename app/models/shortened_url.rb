class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :submitter_id, presence: true
  #validates [:submitter_id, :long_url], uniqueness: true
  
  def self.random_code
    begin
      code = SecureRandom::urlsafe_base64
    end while ShortenedUrl.exists?(short_url: code)
    code
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      :submitter_id => user.id, 
      :long_url => long_url, 
      :short_url => ShortenedUrl.random_code
    )
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visits.select(:visitor_id).distinct.count
  end
  
  def num_recent_uniques
    visits.select(:visitor_id).distinct.where(
      'visits.created_at > ?', 10.minutes.ago
    ).count
  end
  
  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id, 
    primary_key: :id    
  )
  
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  )
  
  has_many(
    :visitors,
    through: :visits,
    source: :visitor
  )
end