class Order < ApplicationRecord
    enum :status, { NEW: 0, PAID: 1, CANCELLED: 2 }

    validates :email, presence: true, format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z/, message: "wrong email format!" }
end
