require 'spec_helper'

RSpec.describe 'Peoples in dollar txt with default order' do
  describe 'dollar formats sorted by first_name' do
    let(:params) do
      {
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        order:         :first_name,
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<first_name>, <city>, <birthdate M/D/YYYY>`
      expect(normalized_people).to eq [
                                        'Rhiannon, LA, 4/30/1974',
                                        'Rigoberto, NYC, 1/5/1962',
                                      ]
    end
  end

  describe 'dollar formats sorted by birthdate in descending order with last_name' do
    let(:params) do
      {
        dollar_format:     File.read('spec/fixtures/people_by_dollar.txt'),
        order:             :birthdate,
        format:            %w(birthdate first_name last_name),
        sorting_direction: :asc
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<birthdate M/D/YYYY>, <first_name>, <last_name>`
      expect(normalized_people).to eq [
                                        '1/5/1962, Rigoberto, Bruen',
                                        '4/30/1974, Rhiannon, Nolan',
                                      ]
    end
  end
end
