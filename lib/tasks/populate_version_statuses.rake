# encoding: utf-8
namespace :populate do
  desc 'Populate version statuses'
  task version_statuses: [ :environment ] do
    Version.all.each do |version|
      version.update_attribute :status, Version::UNAPPROVED
    end
  end
end
