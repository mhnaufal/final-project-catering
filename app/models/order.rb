class Order < ApplicationRecord
    enum status: { NEW: 0, PAID: 1, CANCELLED: 2 }

    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "wrong email format!" }
    validates :status, presence: true , inclusion: { in: statuses }
    validates :total, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
end
