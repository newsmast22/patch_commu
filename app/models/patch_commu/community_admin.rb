# frozen_string_literal: true

class PatchCommu::CommunityAdmin < ApplicationRecord
  self.table_name = 'patchwork_communitys_admins'
  belongs_to :community, class_name: 'PatchCommu::Community', foreign_key: 'community_id'

end