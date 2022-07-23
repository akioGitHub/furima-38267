class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  VALID_PRICE = /\A[0-9]+\z/

  belongs_to :category
  belongs_to :quality
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :term

  belongs_to :user
  has_one :order
  has_one_attached :image
  
  validates :item_name, :image, :detail, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
             presence: { message: "は300円から9,999,999円の間で入力してください" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :quality_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :term_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, format: { with: VALID_PRICE, message: 'は半角数字で入力してください'}

end
