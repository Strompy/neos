require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def setup
    @neo = NearEarthObjects.new('2019-03-30')
  end

  def test_it_exists
    assert_instance_of NearEarthObjects, @neo
  end

  def test_it_has_attributes
    assert_equal '2019-03-30', @neo.date
    assert @neo.parsed_asteroids_data
  end

  def test_it_can_create_connection
    assert NearEarthObjects.create_connection('2019-03-30')
    assert_equal Faraday::Connection, NearEarthObjects.create_connection('2019-03-30').class
  end

  def test_it_can_get_data
    assert NearEarthObjects.get_data('2019-03-30')
    assert_equal Faraday::Response, NearEarthObjects.get_data('2019-03-30').class
  end

  def test_it_can_parse_asteroids_data
    assert NearEarthObjects.parsed_asteroids_data('2019-03-30')
    assert_equal Array, NearEarthObjects.parsed_asteroids_data('2019-03-30').class
  end

  def test_it_can_get_largest_asteroid_diameter
    assert_equal 10233, @neo.largest_asteroid_diameter
  end

  def test_it_can_total_number_of_asteroids
    assert_equal 12, @neo.total_number_of_asteroids
  end

  def test_it_can_format_asteroid_data
    data = @neo.formatted_asteroid_data
    assert_equal "(2019 GD4)", data[0][:name]
  end

  def test_it_can_returns_neos_data
    results = @neo.neos_data
    assert_equal '(2019 GD4)', results[:asteroid_list][0][:name]
  end
end
