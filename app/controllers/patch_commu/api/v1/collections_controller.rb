# frozen_string_literal: true

module PatchCommu::Api::V1
  class CollectionsController < Api::BaseController
    before_action :require_user!, except: [:index, :show]
    before_action :set_collection, only: [:show]

    def index
      @collections = PatchCommu::Collection.order(sorting_index: :asc)
      render json: @collections, each_serializer: PatchCommu::CollectionSerializer
    end

    def show
      render json: @collection, serializer: PatchCommu::CollectionSerializer
    end

    private 

    def set_collection
      @collection = PatchCommu::Collection.find_by(slug: params[:id])
    end

  end
end