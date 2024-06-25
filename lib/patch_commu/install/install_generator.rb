module PatchCommu
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def copy_initializer_file
      copy_file "patch_commu_initializer.rb", Rails.root + "config/initializers/patch_commu_initializer.rb"
    end
    
    def rake_db
      rake("patch_commu:install:migrations")
      rake("db:migrate")
    end
  end
end