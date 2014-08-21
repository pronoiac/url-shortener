class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :submitter, presence: true
  validates :long_url, length: { maximum: 1024 }
  
  validate :cannot_submit_more_than_5_in_one_minute
  
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
  
  has_many(
    :unique_visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
  )
  
  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )
  
  has_many(
    :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :tag_topic
  )
  
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
    unique_visitors.count
  end
  
  def num_recent_uniques
    unique_visitors.where('visits.created_at > ?', 10.minutes.ago).count
  end

  private
  
  def cannot_submit_more_than_5_in_one_minute
    user = User.find(submitter_id)
    count = user.submitted_urls.where(
      'shortened_urls.created_at > ?', 1.minutes.ago).count
      
    if count >= 5
      errors[:base] << "can't submit more than 5 URLs in one minute"
    end
  end
end