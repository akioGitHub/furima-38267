class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end
  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      Payjp.api_key = "sk_test_1182ef2f41f6adc4b4d3e11d"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_shipping_address.save
      redirect_to root_path    
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_shipping_address).permit(:post_code, :prefecture_id, :municipalitie, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

end
