# frozen_string_literal: true

module PatchCommu::Api::V1
  class CommunitiesController < Api::BaseController
    include Authorization
    before_action :require_user!, only: [:index, :show]

    before_action :set_community, only: [:show]

  end
end