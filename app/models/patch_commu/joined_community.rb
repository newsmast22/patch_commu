# frozen_string_literal: true

class PatchCommu::JoinedCommunity < ApplicationRecord
  self.table_name = 'patchwork_joined_communities'
  belongs_to :community, class_name: 'PatchCommu::Community', foreign_key: 'community_id'

end
