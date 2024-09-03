# frozen_string_literal: true

module PatchCommu::Api::V1
  class CommunitiesController < Api::BaseController
    include Authorization
    before_action :require_user!, except: [:index, :show]

    before_action :set_community, only: [:show]

    def index
      if params[:patchwork_collection_id].present?
        @communities = PatchCommu::Community.where(patchwork_collection_id: params[:patchwork_collection_id]).order(position: :asc)
      else
        @communities = PatchCommu::Community.all.order(position: :asc)
      end
      render json: @communities, each_serializer: PatchCommu::CommunitySerializer
    end

    def show
      render json: @community, serializer: PatchCommu::CommunitySerializer
    end

    private

    def set_community
      @community = PatchCommu::Community.find_by(slug: params[:id])
    end

  end
end
