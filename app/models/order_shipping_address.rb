class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalitie, :house_number, :building_name, :phone_number, :order_id, :user_id, :item_id, :token

  VALID_POST_CODE = /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_NUMBER = /\A\d{10,11}\z/

  validates :post_code,:prefecture_id,:municipalitie,:house_number,:phone_number, presence: true
  validates :post_code, format: { with: VALID_POST_CODE, message: "は半角で入力してください"}
  validates :phone_number, format: { with: VALID_PHONE_NUMBER, message: "は10桁か11桁の数字で入力してください"}
  validates :phone_number, numericality: true

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipalitie: municipalitie, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id )
  end

end
