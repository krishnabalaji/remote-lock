require 'pry'
require 'time'

class ProcessData
  attr_reader :data, :options

  def initialize(data, **options)
    @data    = data.select(&method(:is_size_nonzero?))
    @options = options
  end

  def sort
    sorting_column = options[:order].to_s || options[:format]&.first.to_s
    sorting_index  = options[:format].index(sorting_column) || 0
    items          = data.sort_by do |item|
      parse(item[sorting_index], sorting_column == 'birthdate' ? 'Date' : 'String')
    end
    return items unless options[:sorting_direction].to_s == 'descending'
    items.reverse
  end

  private

  def parse(item, type = 'String')
    return item unless type == 'Date'
    month, date, year = item.split('/')
    Time.new(year, month, date).to_i
  end

  def is_size_nonzero?(array)
    array.size.nonzero?
  end
end