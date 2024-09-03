module PatchCommu
  class Engine < ::Rails::Engine
    isolate_namespace PatchCommu

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer 'patch_commu.load_routes' do |app|
      app.routes.prepend do
        mount PatchCommu::Engine => "/", :as => :patchwork
      end
    end

    initializer "my_custom_gem.add_assets_to_webpack" do |app|
      # Add the path to your gem's JavaScript components to Webpack's load paths
      #app.config.assets.paths << root.join('app', 'javascript').to_s

      app.config.assets.precompile += %w(mastodon/features/collections/index.js )

    end

    config.autoload_paths << File.expand_path("../app/services", __FILE__)
    config.autoload_paths << File.expand_path("../app/workers", __FILE__)
  end
end
  