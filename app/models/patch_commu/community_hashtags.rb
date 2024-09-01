# frozen_string_literal: true

class PatchCommu::CommunityHashtags < ApplicationRecord
  self.table_name = 'patchwork_communities_hashtags'
  belongs_to :community, class_name: 'PatchCommu::Community', foreign_key: 'community_id'

end