class AddPositionGuidesParticipantToCommunity < ActiveRecord::Migration[7.0]
  def change
    add_column :patchwork_communities, :position, :integer, default: 0
    add_column :patchwork_communities, :guides, :jsonb, default: {}
    add_column :patchwork_communities, :participants_count, :integer, default: 0
  end
end