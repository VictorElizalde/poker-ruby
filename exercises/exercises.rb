Exercise 1 - Start first clean ups

# BEFORE -------

def straight_flush?(array)
  if straight?(array) and flush?(array)
    return true
  else
    return false
  end
end

# AFTER ---------

def straight_flush?(array)
  straight?(array) && flush?(array)
end

Exercise 2 - Understand the logic and try to simplify it

#  BEFORE --------

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

  helper_array.include?(2)
end

# AFTER -----------

def one_pair?(array)
  hash = Hash.new(0)
  array.each { |item| hash[item / 4] += 1 }
  hash.values.include?(2)
end

Exercise 3 - From procedural to more object oriented code

#  BEFORE --------

def three_of_a_kind?(array)
  hash = Hash.new(0)
  array.each { |item| hash[item / 4] += 1 }
  hash.values.include?(3)
end

# AFTER ----------

def initialize(array)
  @array = array.sort
  @cards = @array.map { |item| item / 4 }
end

def three_of_a_kind?
  hash = Hash.new(0)
  @cards.each { |item| hash[item] += 1 }
  hash.values.include?(3)
end

Exercise 4 - Remove duplication

# BEFORE ---------

def four_of_a_kind?
  hash = Hash.new(0)
  @cards.each { |item| hash[item] += 1 }
  hash.values.include?(4)
end

# AFTER -----------

def initialize(array)
  @array = array.sort
  @cards = @array.map { |item| item / 4 }
  @frequency = cards_frequency
end

def cards_frequency
  hash = Hash.new(0)
  @cards.each { |item| hash[item] += 1 }
  hash.values
end

def four_of_a_kind?
  @frequency.include?(4)
end

