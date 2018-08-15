class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.price = params[:price].to_f
    @item.user = current_user
    @item.save
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:description, :category_id)
  end
end
