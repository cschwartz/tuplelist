class TupleList
  attr_reader :keys

  include Enumerable

  def initialize(required_keys, args = {})
    @keys = required_keys
    @current_tuple = {}
    @tuple_list = []

    @ignore = (args.delete :ignore) || false
  end

  def []=(key, value)
    if @keys.include? key
      @current_tuple[key] = value
    else
      raise "Unspecified key '#{key}' entered" unless @ignore
    end
  end

  def next
    raise "No keys for #{@current_tuple.keys | @keys} specified" unless @current_tuple.length == @keys.length
    @tuple_list << @current_tuple
    @current_tuple = {}
  end

  def each
    @tuple_list.each do |tuple_hash|
      yield tuple_hash.values_at(*@keys)
    end
  end
end
