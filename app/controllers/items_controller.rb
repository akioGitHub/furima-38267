class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    unless user_signed_in?
    redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path(current_user.id)
    else
      render :new
   end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :image, :detail, :price, :category_id, :quality_id, :postage_id, :prefecture_id, :term_id).merge(user_id: current_user.id)
  end


end

