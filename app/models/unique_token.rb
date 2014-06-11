class UniqueToken
  def self.generate
    Digest::SHA1.hexdigest(UUID.generate + Time.current.inspect)
  end
end
