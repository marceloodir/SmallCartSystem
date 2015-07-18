class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  def subtotal
    self.product.preco * self.quantity
  end
end
