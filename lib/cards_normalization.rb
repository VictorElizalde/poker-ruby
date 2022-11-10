# frozen_string_literal: true

class CardsNormalization < Normalization
  private

  def prepare_colors
    @array.map { |item| item % 4 }
  end

  def prepare_figures
    @array.map { |item| item / 4 }
  end
end
