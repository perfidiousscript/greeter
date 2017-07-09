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
        expect(greeting.check_template).to eq(["must contain [\"time\", \"firstName\", \"location\", \"roomNumber\"]"])
      end
    end
  end
  describe 'get_time' do
    context 'with US/Western TZ' do
      it 'should return a greeting' do
        expect(greeting.get_time("US/Western")).to match("Good ")
      end
    end
    context 'vastly different TZs should return vastly different greetings' do
      it 'should return a greeting' do
        expect(greeting.get_time("US/Western")).to_not eq(greeting.get_time("Asia/Baku"))
      end
    end
  end
  describe 'compose_greeting' do
    let(:greeting) { Greeting.new({company: '1', guest: '1', template: Greeting::DEFAULT_TEMPLATE}) }
    let(:formatted_greeting) {"Candy, and welcome to Hotel California! Room 529 is now ready for you. Enjoy your stay and let us know if you need anything!"}
    context 'with a valid user' do
      it 'should work' do
        expect(greeting.compose_greeting).to match(formatted_greeting)
      end
    end
  end
end
