class Generation < ActiveRecord::Base
  attr_accessible :finished_at, :number, :started_at

  belongs_to :version

  validates :number, inclusion: { in: 1..9 }, allow_nil: true

  def label
    label = self.number.to_s

    if self.started_at
      if self.finished_at
        label = "#{label} (#{self.started_at} - #{self.finished_at})"
      else
        label = "#{label} (started in #{self.started_at})"
      end
    end

    label
  end

end
