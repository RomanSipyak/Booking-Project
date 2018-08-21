class ItemsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, on: [:index]

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
    else
      @categories = Category.all
      render 'new'
    end
  end

  def update
    # add errors
    @item = Item.find(params[:id])
    @item.update(item_params)
    @items = Item.includes(:books).where(user: current_user)
    redirect_to items_me_path
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    @items = Item.includes(:books).where(user: current_user)
    redirect_to items_me_path
  end

  def me
    @items = Item.includes(:books).where(user: current_user)
  end

  def index
    if params[:filter]
      params[:by_title].strip!
      @items = Item.book_interval(container_time[:start_booking], container_time[:end_booking])
                   .filter(params.slice(:by_title, :by_city, :by_category))
=begin
      @items = Item.includes(:books)
                   .by_city(params[:filter][:city_id])
                   .by_title(params[:filter][:title])
                   .book_interval(container_time[:start_booking], container_time[:end_booking])
                   .by_category(params[:filter][:category_id])
                   .where.not(user: current_user)
=end
    else
      @items = Item.includes(:books).where.not(user: current_user)
    end
  end

  def show
    @item = Item.includes(:books).find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:description, :category_id, :price, :start_booking)
  end

  def container_time
    start_booking = DateTime.new(params[:filter]['start_booking(1i)'].to_i,
                                 params[:filter]['start_booking(2i)'].to_i,
                                 params[:filter]['start_booking(3i)'].to_i,
                                 params[:filter]['start_booking(4i)'].to_i,
                                 params[:filter]['start_booking(5i)'].to_i,
                                 0)
    end_booking = DateTime.new(params[:filter]['end_booking(1i)'].to_i,
                               params[:filter]['end_booking(2i)'].to_i,
                               params[:filter]['end_booking(3i)'].to_i,
                               params[:filter]['end_booking(4i)'].to_i,
                               params[:filter]['end_booking(5i)'].to_i,
                               0)
    { start_booking: start_booking, end_booking: end_booking }
  end
end
