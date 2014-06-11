class VersionObserver < ActiveRecord::Observer

  def after_create version
    version.create_generation
  end

  def after_update version
    return unless version.status_changed?

    if version.status.to_s == Version::APPROVED.to_s
      NewsFeed.wait_on(version).show!
    else
      NewsFeed.wait_on(version).hide!
    end
  end

end
