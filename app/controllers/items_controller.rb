class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    query = 'SELECT * FROM items ORDER BY id DESC '
    @items = Item.find_by_sql(query)
    @orders = Order.all
  end

  def new
    @item = Item.new
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path(current_user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @item.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :image, :detail, :price, :category_id, :quality_id, :postage_id, :prefecture_id,
                                 :term_id).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == item.user_id
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
