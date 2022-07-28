class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  VALID_PRICE = /\A[0-9]+\z/

  belongs_to :category
  belongs_to :quality
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :term

  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :item_name, :image, :detail, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    presence: { message: 'は300円から9,999,999円の間で入力してください' }
  validates :category_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :quality_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :postage_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :term_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :price, format: { with: VALID_PRICE }
end
