class Child < ApplicationRecord
  belongs_to :parent, inverse_of: :children
end
