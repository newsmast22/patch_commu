# frozen_string_literal: true

class PatchCommu::CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :sorting_index, :banner_image_url, :avatar_image_url

  def banner_image_url
    Rails.application.routes.url_helpers.rails_blob_url(object.banner_image, only_path: true) if object.banner_image.attached?
  end

  def avatar_image_url
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar_image, only_path: true) if object.avatar_image.attached?
  end
end
