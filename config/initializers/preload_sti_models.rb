if Rails.env.development?
  %W[collage gallery_collage profile_collage picture #{File.join("profiles", "picture")} #{File.join("galleries", "picture")}].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
