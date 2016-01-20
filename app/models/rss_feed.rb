class RssFeed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, :through => :user_feeds
  attr_accessible :url
end
