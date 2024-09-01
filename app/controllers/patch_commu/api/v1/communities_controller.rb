# frozen_string_literal: true

module PatchCommu::Api::V1
  class CommunitiesController < Api::BaseController
    include Authorization
    before_action :require_user!, except: [:index, :show]

    before_action :set_communities, only: :show
    before_action :set_status, except: [:index, :create]
    before_action :set_thread, only: [:create]

    after_action :insert_pagination_headers, only: :index

    def index
      render json: render_custom_grouped_dates
    end

    def show
      render json: @status, serializer: LongPost::DraftedStatusSerializer
    end

    private

    def render_custom_grouped_dates
      drafted_statuses = @statuses.group_by { |status| status.created_at.to_date }
      drafted_statuses.map do |date, statuses|
        {
          date: date,
          datas: statuses.map { |status| LongPost::DraftedStatusSerializer.new(status) },
        }
      end
    end

    def set_communities
      @statuses = current_account.patchwork_drafted_statuses.to_a_paginated_by_id(limit_param(DEFAULT_STATUSES_LIMIT), params_slice(:max_id, :since_id, :min_id))
    end

    def set_thread
      @thread = Status.find(drafted_status_params[:in_reply_to_id]) if drafted_status_params[:in_reply_to_id].present?
      authorize(@thread, :show?) if @thread.present?
    rescue ActiveRecord::RecordNotFound, Mastodon::NotPermittedError
      render json: { error: I18n.t('statuses.errors.in_reply_not_found') }, status: 404
    end

    def set_status
      @status = current_account.patchwork_drafted_statuses.find(params[:id])
    end

    def pagination_params(core_params)
      params.slice(:limit).permit(:limit).merge(core_params)
    end

    def insert_pagination_headers
      set_pagination_headers(next_path, prev_path)
    end

    def next_path
      api_v1_drafted_statuses_url pagination_params(max_id: pagination_max_id) if records_continue?
    end

    def prev_path
      api_v1_drafted_statuses_url pagination_params(min_id: pagination_since_id) unless @statuses.empty?
    end

    def records_continue?
      @statuses.size == limit_param(DEFAULT_STATUSES_LIMIT)
    end

    def pagination_max_id
      @statuses.last.id
    end

    def pagination_since_id
      @statuses.first.id
    end

    def options_with_objects(options)
      options.tap do |options_hash|
        options_hash[:application] = Doorkeeper::Application.find(options_hash.delete(:application_id)) if options[:application_id]
        options_hash[:thread]      = Status.find(options_hash.delete(:in_reply_to_id)) if options_hash[:in_reply_to_id]
      end
    end

  end
end
