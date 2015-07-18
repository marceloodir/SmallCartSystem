class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def quantity_total
    qte = 0
    self.line_items.each {|li| qte = qte + li.quantity}
    qte
  end

  def preco_total
    sum = 0
    self.line_items.each {|li| sum = sum + li.subtotal}
    sum
  end
end
