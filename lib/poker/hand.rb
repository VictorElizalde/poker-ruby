require 'pry'

# Poker class
module Poker
  ORDER_CHECKING = [
    :royal_flush, :straight_flush, :four_of_a_kind, :full_house, :flush,
    :straight, :three_of_a_kind, :two_pair, :one_pair, :high_card, :none
  ]

  # Poker hand
  class Hand
    def initialize(array, order_checking = ORDER_CHECKING, normalization = CardsNormalization)
      @array = array.sort
      @figures, @colors = cards_figures_and_colors
      @frequency = cards_frequency.values
      @order_checking = order_checking
      @normalization = normalization
    end

    def check
      @order_checking.each do |name|
        if [:straight, :four_of_a_kind, :three_of_a_kind, :one_pair, :full_house].include? name
          class_name  = 'Poker::' + name.to_s.split('_').collect(&:capitalize).join
          return name if Object.const_get(class_name).new(@array, @normalization).check == name
        else
          method_name = (name.to_s + '?').to_sym
          return name if send(method_name)
        end
      end
    end

    private

    def cards_figures_and_colors
      @array.map { |item| [item / 4, item % 4] }.transpose
    end

    def cards_frequency
      @figures.each_with_object(Hash.new(0)) do |item, hash|
        hash[item] += 1
      end
    end

    # def three_of_a_kind?
    #   @frequency.include?(3)
    # end

    # def one_pair?
    #   @frequency.include?(2)
    # end

    def royal_flush?
      [8, 9, 10, 11, 12] == @figures && flush?
    end

    def straight_flush?
      straight? && flush?
    end

    # def full_house?
    #   three_of_a_kind? && one_pair?
    # end

    def flush?
      @colors.uniq.size == 1
    end

    def straight?
      [0, 1, 2, 3, 12] == @figures || normal_straight?
    end

    def normal_straight?
      @figures.each_cons(2) do |previous, current|
        return false unless previous + 1 == current
      end
      true
    end

    def two_pair?
      (@frequency - [2]).size == 1
    end

    def high_card?
      @figures.last >= 9
    end

    def none?
      true
    end
  end
end
