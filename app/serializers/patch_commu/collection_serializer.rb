# frozen_string_literal: true

class PatchCommu::CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :sorting_index, :banner_image_url, :avatar_image_url, :community_count

  def banner_image_url
    object.banner_image.attached? ? url_for(object.banner_image) : default_image_url
  end

  def avatar_image_url
    object.avatar_image.attached? ? url_for(object.avatar_image) : default_image_url
  end
  
  def community_count
    object.patchwork_communities.count
  end

  private

  def url_for(image)
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
  end

  def default_image_url
    'https://newsmast-assets.s3.eu-west-2.amazonaws.com/default_fallback_resized.png'
  end
end
