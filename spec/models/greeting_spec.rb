# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Greeting, type: :model do
  describe 'check_template' do
    let(:greeting) { Greeting.new }
    context 'with a good template' do
      it 'should return an empty array' do
        greeting.template = Greeting::DEFAULT_TEMPLATE
        expect(greeting.check_template).to eq([])
      end
    end
    context 'with a bad template' do
      it 'should return and array of missing placeholders' do
        greeting.template = 'this is a bad template'
        expect(greeting.check_template).to eq(%w[time name location room])
      end
    end
  end
end
