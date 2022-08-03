class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_root, only: :index
  before_action :set_item, only: [:index, :create]


  def index
    @order_shipping_address = OrderShippingAddress.new
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user.id)

    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
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
    params.require(:order_shipping_address).permit(:post_code, :prefecture_id, :municipalitie, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def move_to_root
    item = Item.find(params[:item_id])
    redirect_to root_path unless current_user.id != item.user_id && item.order.nil?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
