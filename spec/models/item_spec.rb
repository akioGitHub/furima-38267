require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it 'image,item_name,detail,category_id,quality_id,postage_id,prefecture_id,term_id,priceが存在すると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'detailが空では出品できない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end
      it 'category_idが1では出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'quality_idが1では出品できない' do
        @item.quality_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Quality can't be blank")
      end
      it 'postage_idが1では出品できない' do
        @item.postage_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it 'prefecture_idが1では出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'term_idが1では出品できない' do
        @item.term_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Term can't be blank")
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角では出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが文字では出品できない' do
        @item.price = '価格'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが300未満では出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが10,000,000以上では出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'ユーザーが紐づいていない状態だと登録できない' do
        @item.user = nil 
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
