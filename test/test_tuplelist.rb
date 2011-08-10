require 'helper'

class TestTuplelist < MiniTest::Unit::TestCase
  def test_add_tuple_with_missing_values
    tupleList = TupleList.new [:foo, :bar]
    tupleList[:foo] = "foo"
    assert_raises RuntimeError, 'No values for [:bar] specified' do
      tupleList.next
    end
  end

  def test_add_unspecified_key_to_tuple
    tupleList = TupleList.new [:foo]
    assert_raises RuntimeError, "Unspecified key 'bar' entered" do
      tupleList[:bar] = "bar"
    end
  end

  def test_for_each_tuple_if_next_is_called_after_last_row
    tupleList = TupleList.new [:foo, :bar]
    tupleList[:foo] = "foo-1"
    tupleList[:bar] = "bar-1"
    tupleList.next
    tupleList[:foo] = "foo-2"
    tupleList[:bar] = "bar-2"
    tupleList.next

    assert_each tupleList, [["foo-1", "bar-1"], ["foo-2", "bar-2"]]
  end

  def test_for_each_tuple_if_next_is_not_called_after_last_row
    tupleList = TupleList.new [:foo, :bar]
    tupleList[:foo] = "foo-1"
    tupleList[:bar] = "bar-1"
    tupleList.next
    tupleList[:foo] = "foo-2"
    tupleList[:bar] = "bar-2"

    assert_each tupleList, [["foo-1", "bar-1"], ["foo-2", "bar-2"]]
  end

  def test_get_keys
    keys = [:foo, :bar]
    tupleList = TupleList.new keys
    assert_equal keys, tupleList.keys
  end

  def assert_each(expected_enumerable, actual_enumerable, message = "Assertion failed")
    error_messages = []
    actual_enumerable.zip(expected_enumerable) do |actual_value, expected_value|
      error_messages << "'#{actual_value.to_s} does not match '#{expected_value.to_s}'" unless actual_value == expected_value
    end

    raise MiniTest::Assertion.new("#{message}: #{error_messages}") unless error_messages.empty?
  end
end
