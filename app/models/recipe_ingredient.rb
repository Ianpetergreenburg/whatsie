class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  validates_uniqueness_of :order, scope: :recipe_id

  def to_s
    if unit == 'to taste'
      "#{name} #{unit}"
    else
      "#{rational_amount} #{unit} #{name}".strip
    end
  end

  def rational_amount
    return '' if amount == nil || amount == ''
    quotient.to_s + " " + remainder.to_s
  end

  def quotient
    quantity.to_i == 0 ? '' : quantity.to_i
  end

  def remainder
    quantity%1 == 0 ? '' : quantity%1
  end

  def quantity
    Rational(amount)
  end

  def name
    ingredient.name
  end
end
