class Request < ApplicationRecord
  attr_accessor :activation_token, :confirmation_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, conditions: -> { where("confirmed_at > ?", Time.zone.now - 90.days) }
  validates_uniqueness_of :email, conditions: -> { where(activated: false) }
  VALID_PHONE_REGEX = /[\d\-+() ]+/
  validates :phone, presence: true, length: { minimum: 10, maximum: 20 },
                      format: { with: VALID_PHONE_REGEX }
  validates :bio, presence: true, length: { maximum: 2000 }

  # Returns the hash digest of the given string.
  def Request.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Request.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates a request.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
    update_attribute(:confirmed_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    RequestMailer.request_activation(self).deliver_now
  end


  # Confirmes a request.
  def confirm
    update_attribute(:confirmed_at, Time.zone.now)
  end

  # Sends confirmation email in 90 days (request needs to be confirmed every quarter - 92 days max)
  def send_confirmation_email
    create_confirmation_digest
    RequestMailer.request_confirmation(self).deliver_now
    update_attribute(:confirmation_sent_at, Time.zone.now)
  end

  # returns false is the confirmation was sent earlier than 48 hours ago
  def confirmation_reset_expired?
      confirmation_sent_at < 48.hours.ago
    end

  def accept!
    update_attribute(:accepted, true)
  end

  def self.unconfirmed
    where(activated: false)
  end

  def self.confirmed
    where(activated: true).where(accepted: false).where("confirmed_at >= ?", Time.zone.now - 90.days).order(:activated_at)
  end

  def self.accepted
    where(accepted: true)
  end

  def self.expired
    where(activated: true).where("confirmed_at < ?", Time.zone.now - 90.days)
  end

  def waitlist_position
    Request.confirmed.index{|r| r.id == id} + 1
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Request.new_token
      self.activation_digest = Request.digest(activation_token)
    end

    def create_confirmation_digest
      self.confirmation_token  = Request.new_token
      self.confirmation_digest = Request.digest(confirmation_token)
      self.save
    end
end
