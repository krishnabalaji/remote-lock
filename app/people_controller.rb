$: << 'app'
require 'pry'
require 'parse_data'
require 'process_data'

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    data   = []
    format = params[:format] || %w(first_name city birthdate)
    data   += ParseData.new(params[:dollar_format], format: format, separator: '$').items if params[:dollar_format]
    data   += ParseData.new(params[:percent_format], format: format, separator: '%').items if params[:percent_format]
    ProcessData.new(data, **params.slice(:order, :sorting_direction).merge(format: format)).sort.map { |item| item.join(', ') }
  end

  private

  attr_reader :params
end
