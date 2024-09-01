# frozen_string_literal: true

class PatchCommu::Collection < ApplicationRecord
  self.table_name = 'patchwork_collections'

  has_many :patchwork_communities, class_name: 'PatchCommu::Community', foreign_key: 'patchwork_collection_id', dependent: :destroy
  has_one_attached :banner_image
  has_one_attached :avatar_image
  
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :sorting_index, presence: true
 
end