class ReviewsController < ApplicationController
  def new;
  end

  def index
    if params[:user_id]
      @user = User.includes(:reviews).find(params[:user_id])
      @review = Review.new
      @stars_reviews = {}
      @stars_trade = {}
      for i in 1..5 do

        @stars_reviews[i] = @user.reviews.count_reviews_with_raiting(i)

        @stars_trade[i] = @user.items.reduce(0) {|memo, x| memo + x.reviews.count_reviews_with_raiting(i)}

      end

      memo = @stars_reviews.values.reduce(0) {|memo, x| memo + x}
      memo2 = @stars_trade.values.reduce(0) {|memo, x| memo + x}
      if memo != 0
        for i in 1..5 do
          @stars_reviews[i] = {}
          @stars_reviews[i][:star] = @user.reviews.count_reviews_with_raiting(i)
          @stars_reviews[i][:percent] = (@user.reviews.count_reviews_with_raiting(i) / memo.to_f * 5).to_i
        end
      else
        for i in 1..5 do
          @stars_reviews[i] = {}
          @stars_reviews[i][:star] = 0
          @stars_reviews[i][:percent] = 0
        end
      end
      if memo2 != 0
        for i in 1..5 do
          @stars_trade[i] = {}
          @stars_trade[i][:star] = @user.items.reduce(0) {|memo, x| memo + x.reviews.count_reviews_with_raiting(i)}
          @stars_trade[i][:percent] = (@user.items.reduce(0) {|memo, x| memo + x.reviews.count_reviews_with_raiting(i)} / memo2.to_f * 5).to_i
        end
      else
        for i in 1..5 do
          @stars_trade[i] = {}
          @stars_trade[i][:star] = 0
          @stars_trade[i][:percent] = 0
        end
      end

      render 'user_reviews'

    elsif params[:item_id]
      @item = Item.includes(:user).find(params[:item_id])
      @review = Review.new
      @stars = {}
      for i in 1..5 do
        @stars[i] = @item.reviews.count_reviews_with_raiting(i)
      end
      memo = @stars.values.reduce(0) {|memo, x| memo + x}
      if memo != 0
        for i in 1..5 do
          @stars[i] = {}
          @stars[i][:star] = @item.reviews.count_reviews_with_raiting(i)
          @stars[i][:percent] = (@item.reviews.count_reviews_with_raiting(i) / memo.to_f * 5).to_i
        end
      else
        for i in 1..5 do
        @stars[i] = {}
        @stars[i][:star] = 0
        @stars[i][:percent] = 0
        end
      end
p @stars

      render 'item_reviews'
    end
  end

  def edit;
  end

  def update;
  end

  def show;
  end

  def create
    p '1' * 100
    review_params
    p '1' * 100
    @review = Review.new(review_params)
    @review.date = DateTime.current
    @review.user_id = current_user.id
    @review.rating = params[:rating]
    @review.save
    if review_params[:reviewcontainer_type] == 'User'
      @user = User.find(review_params[:reviewcontainer_id])
      @user.rating = @user.reviews.average_rating
      @user.save
      redirect_to user_reviews_path(review_params[:reviewcontainer_id])
    elsif review_params[:reviewcontainer_type] == 'Item'
      @item = Item.find(review_params[:reviewcontainer_id])
      @item.rating = @item.reviews.average_rating
      p user =  @item.user
      user.rating_trade =  @item.user.items.average_rating
      user.save
      @item.save
      redirect_to item_reviews_path(@item)
    end
  end

  def destroy;
  end

  def review_params
    params.require(:review).permit(:reviewcontainer_type, :comment, :reviewcontainer_id, :image, :rating)
  end
end
