# encoding: utf-8
namespace :populate do
  desc 'Populate version generations'
  task generations: [ :environment ] do
    Version.all.each do |version|
      version.create_generation unless version.generation
    end
  end
end
