class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :category
  belongs_to :quality
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :term
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  has_many :comments

  belongs_to :user
  has_many_attached :images
  has_one :order
end
