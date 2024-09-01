# frozen_string_literal: true

require_relative "patch_commu/version"
require "patch_commu/engine"
require 'active_storage/engine'
ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

module PatchCommu
  class Error < StandardError; end
  class << self
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join("config/webpacker.yml")
      )
    end
  end
end



  