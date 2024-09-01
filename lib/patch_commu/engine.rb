# frozen_string_literal: true

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
    
    config.autoload_paths << File.expand_path("../app/services", __FILE__)
    config.autoload_paths << File.expand_path("../app/workers", __FILE__)

    # Add the following line to include the engine's assets
    # patch_commu/mastodon/features/collections/collections.js
    # patch_commu/mastodon/actions/collections/index.jsx
    # patch_commu/mastodon/features/ui/util/async-components.js
    # initializer 'patch_commu.assets.precompile' do |app|
    #   app.config.assets.precompile += %w[
    #     patch_commu/mastodon/features/ui/components/navigation_panel.jsx
    #   ]
    # end
    # 
    #
    initializer "my_custom_gem.add_assets_to_webpack" do |app|
      # Add the path to your gem's JavaScript components to Webpack's load paths
      app.config.assets.paths << root.join('app', 'javascript').to_s
    end

    initializer "my_custom_gem.add_webpack_alias" do |app|
      # Ensure Webpack alias points to your gem's component
      # This allows your component to be used instead of the application's original component
      app.config.webpacker.check_yarn_integrity = false
 
      app.config.webpacker.merge!(
        resolve: {
          alias: {
            # Alias for the ZComponent, replace 'ZComponent' with the actual component name if different
            'NavigationPanel': root.join('app', 'javascript', 'mastodon','features', 'ui', 'components', 'navigation_panel.jsx').to_s
          }
        }
      )
    end
    
    initializer "webpacker.proxy" do |app|
      insert_middleware = begin
                          PatchCommu.webpacker.config.dev_server.present?
                        rescue
                          nil
                        end
      next unless insert_middleware

      app.middleware.insert_before(
        0, Webpacker::DevServerProxy, # "Webpacker::DevServerProxy" if Rails version < 5
        ssl_verify_none: true,
        webpacker: PatchCommu.webpacker
      )
    end

  end
end
  