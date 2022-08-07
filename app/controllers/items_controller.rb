class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :edit
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: :destroy

  def index
    query = 'SELECT * FROM items ORDER BY id DESC '
    @item = Item.find_by_sql(query)
  end

  def new
    @item_tag = ItemTag.new
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @item_tag = ItemTag.new(item_tag_params)
    if @item_tag.valid? 
      @item_tag.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    item_attributes = @item.attributes
    @item_tag = ItemTag.new(item_attributes)
    @item_tag.tag_name = @item.tags&.first&.tag_name
  end

  def update
    @item_tag = ItemTag.new(item_tag_params)
    @item_tag.images ||= @item.images.blobs
    if @item_tag.valid?
      @item_tag.update(item_tag_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if item.destroy
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"])
    render json:{ keyword: tag }
  end

  def item_search
    # params[:q]がnilではない且つ、params[:q][:name]がnilではないとき（商品名の欄が入力されているとき）
    # if params[:q] && params[:q][:name]と同じような意味合い
    if params[:q]&.dig(:item_name)
      # squishメソッドで余分なスペースを削除する
      squished_keywords = params[:q][:item_name].squish
      ## 半角スペースを区切り文字として配列を生成し、paramsに入れる
      params[:q][:item_name_cont_any] = squished_keywords.split(" ")
    end
    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  private

  def item_tag_params
    params.require(:item_tag).permit(:item_name, :detail, :price, :category_id, :quality_id, :postage_id, :prefecture_id,
                                 :term_id, :tag_name, {images: []}).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == item.user_id && item.order.nil?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
