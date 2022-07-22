class ItemsController < ApplicationController
  def index
  end
  def new
  end
  def create
    @item = Item.create(item_params)
  end



  private
  def item_params
    params.require(:item).permit(:item_name, :image, :detail, :category_id, :quality_id, :postage_id, :prefecture_id, :term_id :price).merge(user_id: current_user.id)
  end


end

