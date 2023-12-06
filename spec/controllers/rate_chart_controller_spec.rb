# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RateChartController, type: :controller do
  describe 'GET #index' do
    let(:data) { 'some data' }

    it 'assigns chart_data to @chart_data' do
      allow_any_instance_of(RateProcessor).to receive(:get_chart_data).and_return({ data: })

      get :index

      expect(assigns(:chart_data)).to eq({ data: }.to_json)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end

    it 'responds with success' do
      get :index

      expect(response).to be_successful
    end
  end
end
