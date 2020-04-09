class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Customer < ApplicationRecord
  validates :email, presence: true, email:true, uniqueness: true
  validates :name, presence: true
  validates :lastname, presence: true
  has_many :orders
  has_many :tickets, through: :orders
end
