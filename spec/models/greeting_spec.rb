# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Greeting, type: :model do
  let(:greeting) { Greeting.new({company: '1', guest: '1', template: ""}) }
  describe 'check_template' do
    context 'with a good template' do
      it 'should return an empty array' do
        greeting.template = Greeting::DEFAULT_TEMPLATE
        expect(greeting.check_template).to eq(nil)
      end
    end
    context 'with a bad template' do
      it 'should return and array of missing placeholders' do
        greeting.template = 'this is a bad template'
        expect(greeting.check_template).to eq(["must contain [\"time\", \"name\", \"location\", \"room\"]"])
      end
    end
  end
  describe 'get_time' do
    context 'with US/Western TZ' do
      it 'should return a greeting' do
        expect(greeting.get_time("US/Western")).to eq("Good Morning"||"Good Evening"||"Good Night")
      end
    end
    context 'vastly different TZs should return vastly different greetings' do
      it 'should return a greeting' do
        expect(greeting.get_time("US/Western")).to_not eq(greeting.get_time("Indian/Chagos"))
      end
    end
  end
end
