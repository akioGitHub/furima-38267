require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '購入できるとき' do
      it 'post_code,prefecture_id,municipalitie,house_number,building_name,phone_numberが存在すれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'building_nameが空でも購入できる' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '購入できないとき' do
      it 'post_codeが空では購入できない' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'prefecture_idが1では購入できない' do
        @order_shipping_address.prefecture_id = '1'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'municipalitieが空では購入できない' do
        @order_shipping_address.municipalitie = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空では購入できない' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'post_codeが全角では購入できない' do
        @order_shipping_address.post_code = '１２３−４５６７'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号は半角で入力してください')
      end
      it 'phone_numberが全角では購入できない' do
        @order_shipping_address.phone_number = '０９０１２３４５６７８'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが9桁では購入できない' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが12桁では購入できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが数値以外では購入できない' do
        @order_shipping_address.phone_number = '090-123-456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は10桁か11桁の半角数字で入力してください')
      end
      it 'tokenが空では購入できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("クレジット情報を入力してください")
      end
      it 'userが紐づいていない状態だと登録できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐づいていない状態だと登録できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
