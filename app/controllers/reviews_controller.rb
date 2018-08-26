class ReviewsController < ApplicationController
  def new
  end

  def index
    if params[:user_id]
      @user = User.includes(:reviews).find(params[:user_id])
      @review = Review.new
      p "1"
      render 'user_reviews'
    elsif params[:item_id]
      @item = Item.includes(:user).find(params[:item_id])
      @review = Review.new
      p "0"
      render 'item_reviews'
    end
  end

  def edit

  end

  def update
  end

  def show
  end

  def create
    p '1'*100
    review_params
    p '1'*100
    @review = Review.new(review_params)
    @review.date = DateTime.current
    @review.user_id = current_user.id
=begin
    review.rating = params[:rating]
=end
    @review.save
    if review_params[:reviewcontainer_type] == 'User'
      redirect_to user_reviews_path(review_params[:reviewcontainer_id])
    elsif review_params[:reviewcontainer_type] == 'Item'
      @item = Item.find(review_params[:reviewcontainer_id])
=begin
      item.rating = item.reviews.average_rating
      item.save
=end
     redirect_to item_reviews_path(@item)
    end
  end

  def destroy
  end

  def review_params
    params.require(:review).permit(:reviewcontainer_type, :comment, :reviewcontainer_id,:image)
  end
end
