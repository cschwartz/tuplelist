class TupleList
  attr_reader :keys

  include Enumerable

  def initialize(required_keys)
    @keys = required_keys
    @current_tuple = {}
    @tuple_list = [@current_tuple] 
  end

  def []=(key, value)
    raise "Unspecified key '#{key}' entered" unless @keys.include? key
    @current_tuple[key] = value 
  end

  def next
    raise "No keys for #{@current_tuple.keys & @keys} specified" unless @current_tuple.length == keys.length
    @current_tuple = {}
    @tuple_list << @current_tuple
  end

  def each
    @tuple_list.each do |tuple_hash|
      yield tuple_hash.values_at(*@keys)
    end
  end
end
