class User < ActiveRecord::Base

  MAILCHIMP_API_KEY = 'm23lm092m3'

  has_many :orders
  has_many :packages, through: :orders

  before_save :assign_referral_code, on: :create
  after_create :schedule_welcome_email
  
  validates_presence_of :email, :fname, :lname
  validates :referral_code, uniqueness: true

  scope :recently_created, where("created_at <= #{Date.today - 2.days}")

  def name
    self.fname + ' ' + self.lname
  end

  def formatted_name
    "<strong>#{name}</strong> (<a href=\"mailto:#{email}\">#{email}</a>)"
  end

  def assign_referral_code
    referral_code = SecureRandom.hex(6)
  end

  def schedule_welcome_email
    Mailer.delay.welcome(self) # Queue email with DelayedJob
  end

  def has_orders
    orders.any?
  end

  def most_recent_package_shipping_address
    order.last.package.shipping_address
  end

  def can_manage?
    (email = 'manager@example.com') or (email = 'admin@example.com')
  end

  def order_product(product)
    result = OrderProcessor.charge(self, product)

    if result
      Event.log_order_processing(self)
      Mailer.order_confirmation(self, product).deliver
      return true
    else
      Event.log_failed_order_processing(self)
      return false
    end
  end

  def self.delete_user(email)
    begin
      user = User.find_by_email(email)
      user.destroy!
    rescue Exception => e # email not found
      Rails.logger.error("Could not delete user with email #{email}")
    end
  end

end

# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(255)      default(""), not null
#  fname                     :string(255)      default(""), not null
#  lname                     :string(255)      default(""), not null
#  referral_code             :string(255)
#  created_at                :datetime
#  updated_at                :datetime
