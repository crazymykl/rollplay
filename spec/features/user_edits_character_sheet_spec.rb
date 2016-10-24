require 'rails_helper'

feature 'user can edit character sheets' do
  let!(:character) { FactoryGirl.create(:character) }
  context 'as a logged-in user' do
    scenario 'there is a link to edit the sheet' do
      visit character_path(character)
      click_link 'Edit'

      expect(current_path).to eq(edit_character_path(character))
    end

    scenario 'user can change information' do
      visit edit_character_path(character)
      fill_in 'Race', with: 'Clone'
      fill_in 'Appearance', with: 'No more zombie eyes'
      fill_in 'Constitution', with: 9
      click_button 'Save Sheet'

      expect(page).to have_content 'Georgia Mason'
      expect(page).to have_content 'Race: Clone'
      expect(page).to have_content 'Appearance: No more zombie eyes'
      expect(page).not_to have_content 'Short black hair, sunglasses, creepy zombie eyes'
      expect(page).to have_content 'Con: 9 | -1'
    end
  end

  context 'as a logged-off user' do
    scenario 'logged-off users have no edit link' do
      visit character_path(character)

      expect(page).not_to have_link('Edit')
    end

    scenario 'logged-off users cannot edit' do
      visit edit_character_path(character)

      expect(page).to have_content("You need to sign in before continuing.")
    end
  end
end
