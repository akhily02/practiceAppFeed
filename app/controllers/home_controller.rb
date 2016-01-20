class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @session = user_signed_in?
    @user = current_user

    feeds = Array.new

    @rss_feed = RssFeed.all
    @rss_feed.each do |feed|
      url = feed.url #get the url of the feed from the rss_feed table where the feedID matches
      parsedFeed = Feedjira::Feed.fetch_and_parse url # parse the xml
      feeds.push(parsedFeed)  # push the parsed xml in the feeds array
    end
    @rss_feeds = feeds
  end

end