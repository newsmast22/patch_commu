require "webpacker/helper"

module PatchCommu
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      PatchCommu.webpacker
    end
  end
end