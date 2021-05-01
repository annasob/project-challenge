require 'rails_helper'

RSpec.describe DogsController, type: :controller do

  let(:user_one) { create(:user) }
  let(:user_two) { create(:user) }

  before do
    2.times { create(:dog, owner: user_one) }
    3.times { create(:dog, owner: user_two) }
  end

  describe '#index' do
    it 'displays recent dogs' do
      allow(controller).to receive(:current_user).and_return(false)
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end

    it 'displays dogs belonging to the logged in user' do
      sign_in user_one
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end
  end

  describe '#update' do
    def dog_params
      {
        name: "New Name",
      }
    end
    it 'allows updating by the dogs owner' do
      sign_in user_one
      @dog = Dog.for_owner(user_one).first
      put :update, params: { id: @dog.id, dog: dog_params }, format: :json
      expect(response).to be_successful
    end

    it 'denies updating when not the dogs owner' do
      sign_in user_one
      @dog = Dog.for_owner(user_two).first
      put :update, params: { id: @dog.id, dog: dog_params }, format: :json
      expect(response).not_to be_successful
    end
  end

  describe '#destroy' do
    it 'allows deleting by the dogs owner' do
      sign_in user_one
      @dog = Dog.for_owner(user_one).first
      delete :destroy, params: { id: @dog.id }, format: :json
      expect(response).to be_successful
    end

    it 'denies deleting when not the dogs owner' do
      sign_in user_one
      @dog = Dog.for_owner(user_two).first
      delete :destroy, params: { id: @dog.id }, format: :json
      expect(response).not_to be_successful
    end
  end
end
