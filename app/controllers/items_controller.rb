class ItemsController < ApplicationController
  def index
    query = 'SELECT * FROM items ORDER BY id DESC '
    @items = Item.find_by_sql(query)
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

  private

  def item_params
    params.require(:item).permit(:item_name, :image, :detail, :price, :category_id, :quality_id, :postage_id, :prefecture_id,
                                 :term_id).merge(user_id: current_user.id)
  end
end
