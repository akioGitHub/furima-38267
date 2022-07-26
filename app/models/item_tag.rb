class ItemTag
  include ActiveModel::Model

  attr_accessor(
    :item_name, :images, :detail, :category_id, :quality_id, :postage_id, :prefecture_id, 
    :term_id, :price, :user_id, :id, :created_at, :datetime, :updated_at, :datetime, :tag_name
  )
  VALID_PRICE = /\A[0-9]+\z/

  validates :item_name, :images, :detail, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    presence: { message: 'は300円から9,999,999円の間で入力してください' }
  validates :category_id, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:10, message: "を入力してください" }
  validates :quality_id, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:6, message: "を入力してください" }
  validates :postage_id, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:2, message: "を入力してください" }
  validates :prefecture_id, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:47, message: "を入力してください" }
  validates :term_id, numericality: { greater_than_or_equal_to:1 ,less_than_or_equal_to:3, message: "を入力してください" }
  validates :price, format: { with: VALID_PRICE }
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }

  def save
    item = Item.create(
      item_name: item_name, images: images, detail: detail, category_id: category_id, quality_id: quality_id, 
      postage_id: postage_id, prefecture_id: prefecture_id, term_id: term_id, price: price, user_id: user_id
    )
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)    
  end

  def update(params, item)
    #一度タグの紐付けを消す
    item.item_tag_relations.destroy_all

    #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    #タグを保存
    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end