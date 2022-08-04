class ItemTag
  include ActiveModel::Model

  attr_accessor(
    :item_name, :images, :detail, :category_id, :quality_id, :postage_id, 
    :prefecture_id, :term_id, :price, :user_id, :id, :created_at, :datetime, :updated_at, :datetime
  )
  VALID_PRICE = /\A[0-9]+\z/

  validates :item_name, :images, :detail, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    presence: { message: 'は300円から9,999,999円の間で入力してください' }
  validates :category_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :quality_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :postage_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :term_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :price, format: { with: VALID_PRICE }
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }

  def save
    Item.create(item_name: item_name, images: images, detail: detail, category_id: category_id, quality_id: quality_id, postage_id: postage_id, prefecture_id: prefecture_id, term_id: term_id, price: price, user_id: user_id)
  end

  def update(params, item)
    item.update(params)
  end
end