class RssFeedsController < ApplicationController
  before_filter :authenticate_user!

  def index

    @session = user_signed_in?
    @user = current_user

    feeds = Array.new
    @user_feed = UserFeed.where(user_id: current_user.id) #get the rss feedID from the table user_feed for the current user ID

    @user_feed.each do |feed|
      url = RssFeed.where(id: feed.rss_feed_id).first.url #get the url of the feed from the rss_feed table where the feedID matches
      #xml = Faraday.get(url).body
      parsedFeed = Feedjira::Feed.fetch_and_parse url # parse the xml
      feeds.push(parsedFeed)  # push the parsed xml in the feeds array
    end
    @rss_feeds = feeds



  end

  def new
    @session = user_signed_in?
    @user = current_user
    @rss_feed = RssFeed.new
  end

  def create
    @session = user_signed_in?
    @user = current_user
    @user =  current_user.id
    @rss_feed =RssFeed.where(params[:rss_feed])

    if @rss_feed.present? #if the rss feed url already present in the rss_feed table
      @user_feed = UserFeed.where(user_id: @user, rss_feed_id: rss_feed.first.id)
      if @user_feed.present?  #if the user has already applied for that feed
        render 'new'
      else#else-if the user is applying for a new feed
        @user_feed = UserFeed.new user_id: @user, rss_feed_id: @rss_feed.first.id
      end
      @user_feed.save

  else  #else-if the user entered a completely new rss feed url
    @rss_feed = RssFeed.new(params[:rss_feed])
    @rss_feed.save
    @user_feed = UserFeed.new user_id: @user, rss_feed_id: @rss_feed.id
    @user_feed.save
  end

    redirect_to rss_feeds_path
  end



end