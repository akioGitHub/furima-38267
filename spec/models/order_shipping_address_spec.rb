require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @order_shipping_address = FactoryBot.build(:order_shipping_address)
  end

  describe '商品購入' do
    context '購入できるとき' do
      it 'post_code,prefecture_id,municipalitie,house_number,building_name,phone_numberが存在すれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end
    end

    context '出品できないとき' do
      it 'post_codeが空では購入できない' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank", 'Post code は半角で入力してください')
      end
      it 'prefecture_idが空では購入できない' do
        @order_shipping_address.prefecture_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalitieが空では購入できない' do
        @order_shipping_address.municipalitie = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Municipalitie can't be blank")
      end
      it 'house_numberが空では購入できない' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'post_codeが全角では購入できない' do
        @order_shipping_address.post_code = '１２３−４５６７'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Post code は半角で入力してください')
      end
      it 'phone_numberが全角では購入できない' do
        @order_shipping_address.phone_number = '０９０１２３４５６７８'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが9桁では購入できない' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが12桁では購入できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number は10桁か11桁の半角数字で入力してください')
      end
      it 'phone_numberが数値以外では購入できない' do
        @order_shipping_address.phone_number = '090-123-456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number は10桁か11桁の半角数字で入力してください')
      end
    end
  end
end
