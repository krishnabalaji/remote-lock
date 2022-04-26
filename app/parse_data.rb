require 'pry'
require 'date'

class ParseData
  attr_reader :raw_data, :separator, :format

  def initialize(raw_data, separator: '$', format: %w(first_name city birthdate))
    @raw_data  = raw_data
    @separator = separator
    @format    = format
  end

  def items
    parse_data[1..-1].map do |data|
      format.map.with_index do |item|
        next unless headers.index(item)
        parse_item(data[headers.index(item)], item == 'birthdate' ? 'Date' : 'String')
      end.compact
    end
  end

  private

  def headers
    parse_data[0]
  end

  def parse_item(item, type = 'String')
    return item unless type == 'Date'
    Date.parse(item).strftime('%-m/%-d/%Y')
  end

  def parse_data
    @parsed_data ||= raw_data.split("\n").map do |item|
      item.split(separator).map(&:strip)
    end
  end
end