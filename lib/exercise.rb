module Poker
  # Poker hand
  class Hand
    def check(array)
      array.sort!
      return 9 if straight_flush?(array)
      return 8 if four_of_a_kind?(array)
      return 7 if full_house?(array)
      return 6 if flush?(array)
      return 3 if two_pair?(array)
      return 2 if one_pair?(array)
      return 4 if three_of_a_kind?(array)
      return 5 if straight?(array)
      return 1 if high_card?(array)
      return 0
    end

    def straight_flush?(array)
      if straight?(array) and flush?(array)
        return true
      else
        return false
      end
    end

    def four_of_a_kind?(array)
      tmp = array.clone
      tmp.collect!{|x| x / 4 }

      helper_array = [0] * 13

      tmp.each do |elem|
        helper_array[elem] += 1
      end

      helper_array.delete(0)

      if helper_array.include?(4) and helper_array.include?(1)
        return true
      else
        return false
      end
    end

    def full_house?(array)
      tmp = array.clone
      tmp.collect!{|x| x / 4 }

      helper_array = [0] * 13

      tmp.each do |elem|
        helper_array[elem] += 1
      end

      helper_array.delete(0)

      if helper_array.include?(3) and helper_array.include?(2)
        return true
      else
        return false
      end
    end

    def flush?(array)
      tmp = array.clone
      tmp.collect!{|x| x % 4 }

      if tmp.uniq.length == 1
        return true
      else
        return false
      end
    end

    def straight?(array)
      if array.last / 4 == 12
        return straight_with_ace?(array)
      else
        return true_straight?(array)
      end
    end

    def straight_with_ace?(array)
      if true_straight?(array)
        return true
      else
        tmp = array.clone
        tmp.collect!{|x| x / 4}
        tmp.delete(12)

        sum = 0;
        tmp.each do |num|
          sum += num
        end

        if sum == 6
          return true
        else
          return false
        end
      end
    end

    def true_straight?(array)
      tmp = array.clone
      minimum_card = tmp[0] / 4

      tmp.collect!{|x| x / 4 - minimum_card}

      sum = 0;
      tmp.each do |num|
        sum += num
      end

      if sum == 10
        return true
      else
        return false
      end
    end

    def three_of_a_kind?(array)
      tmp = array.clone
      tmp.collect!{|x| x / 4 }

      helper_array = [0] * 13

      tmp.each do |elem|
        helper_array[elem] += 1
      end

      helper_array.delete(0)

      if helper_array.include?(3) and helper_array.include?(1)
        return true
      else
        return false
      end
    end

    def two_pair?(array)
      tmp = array.clone
      tmp.collect!{|x| x / 4 }

      helper_array = [0] * 13

      tmp.each do |elem|
        helper_array[elem] += 1
      end

      helper_array.delete(0)

      if helper_array.include?(2) and helper_array.length == 3
        return true
      else
        return false
      end
    end

    def one_pair?(array)
      tmp = array.clone
      tmp.collect!{|x| x / 4 }

    #  (0..8).each do |elem|
    #    tmp.delete(elem)
    #  end

      helper_array = [0] * 13

      tmp.each do |elem|
        helper_array[elem] += 1
      end

      helper_array.delete(0)

      if helper_array.include?(2)
        return true
      else
        return false
      end
    end

    def high_card?(array)
      if array.last >= 36
        return true
      else
        return false
      end
    end
  end
end