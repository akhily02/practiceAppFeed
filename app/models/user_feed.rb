class UserFeed < ActiveRecord::Base
  belongs_to :rss_feeds
  belongs_to :users
  attr_accessible :user_id, :rss_feed_id
  # attr_accessible :title, :body
end
