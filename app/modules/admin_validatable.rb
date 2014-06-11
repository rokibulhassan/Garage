module AdminValidatable
  STATUSES = %w(accepted rejected pending)
  InvalidApprovalStatus = Class.new(StandardError)

  extend ActiveSupport::Concern
  included do
    after_create :pending!, :unless => lambda { |model| model.accepted? }
    after_update :set_approval_status, :if =>  lambda { |model| model.approval_status.in?(STATUSES) }
  end

  module ClassMethods
    def accepted
      where(:rejected => false, :pending => false)
    end

    def rejected
      where(:rejected => true)
    end
    def not_rejected
      where(:rejected => false)
    end

    def pending
      where(:pending => true)
    end
  end

  attr_accessor :approval_status

  def accept!
    self.rejected = self.pending = false
    save!
  end
  alias accepted! accept!
  
  def reject!
    self.rejected = true
    self.pending = false
    save!
  end
  alias rejected! reject!

  def pending!
    set_pending
    self.rejected = false
    save!
  end

  def accepted?
    rejected == false && pending == false
  end

  def rejected?
    rejected
  end

  def pending?
    pending
  end

  protected

  def set_pending
    self.pending = true
    self.rejected = false
  end

  def set_approval_status
    status_name = approval_status
    # avoid infinite after_update loop as last line saves record again
    self.approval_status = nil
    send("#{status_name}!")
  end

  def _approval_status
    if accepted?
      'accepted'
    elsif rejected?
      'rejected'
    elsif pending?
      'pending'
    else
      raise InvalidApprovalStatus, "expected statuses to be one of #{STATUSES.join(', ')}"
    end
  end
end
