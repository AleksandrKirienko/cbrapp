require 'rails_helper'

RSpec.describe RateDeltaController, type: :controller do
  describe 'GET #index' do
    let(:deltas) { 'some delta' }

    it 'assigns @deltas with summary deltas for default week count' do
      allow_any_instance_of(RateProcessor).to receive(:get_summary_deltas).with(RateDeltaController::DEFAULT_WEEK_COUNT).and_return(deltas)

      get :index

      expect(assigns(:deltas)).to eq(deltas)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end

    it 'returns a successful response' do
      get :index

      expect(response).to be_successful
    end
  end
end