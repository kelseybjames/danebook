require 'rails_helper'

describe 'photos/index.html.erb' do
  let(:user){ create(:user) }
  let(:photos){ create_list(:photo, 5, user: user) }