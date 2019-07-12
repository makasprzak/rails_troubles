class Parent < ApplicationRecord
  has_many :children, -> { order(created_at: :asc) }, inverse_of: :parent

  accepts_nested_attributes_for :children, allow_destroy: true
end
