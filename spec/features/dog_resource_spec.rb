require 'rails_helper'

describe 'Dog resource', type: :feature do
   let(:user) { create(:user) }
   let(:current_user) { create(:user) }

  it 'can create a profile' do
    sign_in user
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'dog_image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can create a profile with multiple images' do
    sign_in user
    visit new_dog_path
    fill_in 'Name', with: 'Speck Two'
    fill_in 'Description', with: 'Just a dog with two images'
    attach_file 'dog_image', ['spec/fixtures/images/speck.jpg','spec/fixtures/images/bijou.jpg']
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
    dob = Dog.find_by_name("Speck Two")
    expect(dob.images.count).to eq(2)
  end

  it 'can edit a dog profile' do
    sign_in user
    dog = create(:dog, owner: user)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    sign_in user
    dog = create(:dog, owner: user)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end