# frozen_string_literal: true

PatchCommu::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :collections, only: [:index, :show]
    end
  end
end
  