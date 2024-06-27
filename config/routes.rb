Rails.application.routes.draw do
    mount PatchCommu::Engine, at: '/patch_commu'
  end
  