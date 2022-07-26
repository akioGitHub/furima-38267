class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end
  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    end
  end

  private

  def order_params
    params.permit(:post_code, :prefecture_id, :municipalitie, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, order_id: @order_shipping_address.order.id)
  end

end
