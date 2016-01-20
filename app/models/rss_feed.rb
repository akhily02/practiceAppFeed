class RssFeed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, :through => :user_feeds
  attr_accessible :url

  searchable do
    text:url
  end
end
