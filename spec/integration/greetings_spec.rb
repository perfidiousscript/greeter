# frozen_string_literal: true

require 'rails_helper'

feature 'Greetings' do
  context 'the default greeting' do
    it 'should work' do
      visit new_greeting_path
      click_button 'Create Greeting'
      expect(page.body).to match('Candy, and welcome to Hotel California! Room 529 is now ready for you. Enjoy your stay and let us know if you need anything!')
    end
  end
  context 'with a user altered template' do
    context 'that lacks the template pieces' do
      it 'should return an error' do
        visit new_greeting_path
        fill_in(:template, with: 'this is a bad template')
        click_button 'Create Greeting'
        expect(page.body).to have_content('Error: {:template=>["must contain [\\"time\\", \\"firstName\\", \\"location\\", \\"roomNumber\\"]"]}')
      end
    end
    context 'that has all template pieces' do
      let(:altered_template) { 'Well time there firstName! You are now in location! Head on over to roomNumber, it should be all set!' }
      let(:processed_altered_template) { 'Well Good Afternoon there Candy! You are now in Hotel California! Head on over to 529, it should be all set!' }
      it 'should render the template' do
        visit new_greeting_path
        fill_in(:template, with: altered_template)
        click_button 'Create Greeting'
        expect(page.body).to have_content(processed_altered_template)
      end
    end
    context 'that has all template pieces plut optional ones' do
      let(:optional_template) { 'Well time there firstName lastName! You are now the the city location! Head on over to roomNumber, it should be all set!' }
      let(:processed_optional_template) { 'Well Good Afternoon there Candy Pace! You are now the the Santa Barbara Hotel California! Head on over to 529, it should be all set!' }
      it 'should render the template' do
        visit new_greeting_path
        fill_in(:template, with: optional_template)
        click_button 'Create Greeting'
        expect(page.body).to have_content(processed_optional_template)
      end
    end
  end
end
