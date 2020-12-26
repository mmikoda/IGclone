class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action:logged_in?, only:[:new,:create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end
  
  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if params[:back]
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      else
        if @feed.save
          FeedMailer.feed_mail(@feed).deliver
          format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def feed_params
    params.require(:feed).permit(:image, :image_cache, :title, :content, :user_id, :feed_id, :email)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def correct_user
    if current_user.id != @feed.user_id
      flash[:notice] = "権限がないです"
      redirect_to feeds_path
    end
  end
end
