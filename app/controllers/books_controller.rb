class BooksController < ApplicationController
  def new
    @item = Item.includes(:books).find(params[:item_id])
    @booking = Book.new
  end

  def index; end

  def edit; end

  def update; end

  def show; end

  def create
    #     Add permit and you will can delete its
    #     start_booking = DateTime.new(params[:book]['start_booking(1i)'].to_i,
    #                                  params[:book]['start_booking(2i)'].to_i,
    #                                  params[:book]['start_booking(3i)'].to_i,
    #                                  params[:book]['start_booking(4i)'].to_i,
    #                                  params[:book]['start_booking(5i)'].to_i,
    #                                  0)
    #     end_booking = DateTime.new(params[:book]['end_booking(1i)'].to_i,
    #                                  params[:book]['end_booking(2i)'].to_i,
    #                                  params[:book]['end_booking(3i)'].to_i,
    #                                  params[:book]['end_booking(4i)'].to_i,
    #                                  params[:book]['end_booking(5i)'].to_i,
    #                                  0)
    @booking = Book.new(booking_params)
    #     @booking.start_booking = start_booking
    #     @booking.end_booking = end_booking

    @item = Item.find(params[:item_id])

    @booking.total_price = (@booking.end_booking - @booking.start_booking) * (@item.price / 86_400)
    @booking.item=@item
    @booking.user = current_user
    @booking.save!
  end

  def destroy; end

  def booking_params
    params.require(:book).permit(:end_booking, :start_booking, :item_id)
  end
end
