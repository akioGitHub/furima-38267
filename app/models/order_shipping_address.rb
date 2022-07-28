class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalitie, :house_number, :building_name, :phone_number, :order_id, :user_id,
                :item_id, :token

  VALID_POST_CODE = /\A[0-9]{3}-[0-9]{4}\z/
  VALID_PHONE_NUMBER = /\A[0-9]{10,11}\z/

  validates :post_code, :municipalitie, :house_number, :phone_number, :token, :user_id, :item_id, presence: true
  validates :post_code, format: { with: VALID_POST_CODE, message: 'は半角で入力してください' }
  validates :phone_number, format: { with: VALID_PHONE_NUMBER, message: 'は10桁か11桁の半角数字で入力してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :phone_number, numericality: true

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipalitie: municipalitie,
                           house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
