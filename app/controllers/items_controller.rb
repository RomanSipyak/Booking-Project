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
  end

  def edit

  end

  def destroy
  end

  def me
    @items = Item.includes(:books).where(user: current_user)
  end

  def index
    @items = Item.includes(:books).where.not(user: current_user)
  end

  def show
    @item = Item.includes(:books).find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:description, :category_id, :price)
  end
end
