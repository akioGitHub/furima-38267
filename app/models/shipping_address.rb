class ShippingAddress < ApplicationRecord
  VALID_POST_CODE = /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_NUMBER = /\A\d{10,11}\z/
  belongs_to :order

  validates :post_code,:prefecture_id,:municipalitie,:house_number,:phone_number, presence: true
  validates :price, format: { with: VALID_POST_CODE, message: "は半角で入力してください"}
  validates :phone_number, format: { with: VALID_PHONE_NUMBER, message: "は10桁か11桁の数字で入力してください"}
  validates :phone_number, numericality: true
end
