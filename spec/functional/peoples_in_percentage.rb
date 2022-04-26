require 'spec_helper'

RSpec.describe 'Peoples in percentage txt with default order' do
  describe 'percentage formats sorted by city and select only city' do
    let(:params) do
      {
        percent_format:    File.read('spec/fixtures/people_by_percent.txt'),
        order:             :city,
        format:            %w(city),
        sorting_direction: :descending
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<city>`
      expect(normalized_people).to eq ['New York City', 'Atlanta']
    end
  end

  describe 'percentage with wrong formats' do
    let(:params) do
      {
        percent_format:    File.read('spec/fixtures/people_by_percent.txt'),
        order:             :city,
        format:            %w(name),
        sorting_direction: :descending
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<city>`
      expect(normalized_people).to eq []
    end
  end
end
