# frozen_string_literal: true

class PatchCommu::Community < ApplicationRecord
  self.table_name = 'patchwork_communities'

  belongs_to :patchwork_collection, class_name: 'PatchCommu::Collection', foreign_key: 'patchwork_collection_id'
  has_many :joined_communities, class_name: 'PatchCommu::JoinedCommunity', foreign_key: 'patchwork_community_id', dependent: :destroy
  has_many :community_hashtags, class_name: 'PatchCommu::CommunityHashtags', foreign_key: 'patchwork_community_id', dependent: :destroy
  has_many :community_admins, class_name: 'PatchCommu::CommunityAdmin', foreign_key: 'patchwork_community_id', dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 500 }
end