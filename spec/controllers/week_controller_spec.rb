require 'spec_helper'

describe WeekController do
  after do
    Timecop.return
  end

  let!(:rafal) {create(:user, email: 'rafal@selleo.com', name: 'Rafal', retired: true)}
  let!(:wojtek) {create(:user, email: 'wojtek@selleo.com', name: 'Wojtek', retired: true)}
  let!(:adrian) {create(:user, email: 'adrian@selleo.com', name: 'Adrian')}

  let!(:tom) { create(:user, email: 'tom@selleo.com', name: 'Tom') }
  let!(:bart) { create(:user, email: 'bart@selleo.com', name: 'Bart') }
  let!(:simon) { create(:user, email: 'simon@selleo.com', name: 'Simon') }
  let!(:radek) { create(:user, email: 'radek@selleo.com', name: 'Radek') }
  let!(:stevo) { create(:user, email: 'stevo@selleo.com', name: 'Stevo') }

  before do
    Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))

    adrian.thanks_to_user(wojtek, {value: 20})

    # bart +13 -1
    tom.thanks_to_user(bart, {value: 3})
    tom.thanks_to_user(bart, {value: 2})
    tom.thanks_to_user(bart, {value: 1})
    simon.thanks_to_user(bart, {value: 5})
    simon.thanks_to_user(bart, {value: 1})

    # tom +1 -6
    simon.thanks_to_user(tom, {value: 1})
    radek.thanks_to_user(bart, {value: 1})

    # radek +3 -1
    simon.thanks_to_user(radek, {value: 2})
    bart.thanks_to_user(radek, {value: 1})
    # simon -9

    Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
  end

  describe "top_collectors" do
    before do
      get :top_collectors
    end

    subject(:response_object) { JSON.parse(response.body)["tops"] }
    let(:users) { [tom, bart, radek].map(&:ember_user_info).map(&:stringify_keys) }
    it { expect(response_object).to include(*users) }
  end

  describe "top_hamsters" do
    before do
      get :top_hamsters
    end

    subject(:response_object) { JSON.parse(response.body)["hamsters"] }
    let(:users) { [stevo, bart, radek].map(&:ember_user_info).map(&:stringify_keys) }

    it { expect(response_object).to include(*users) }
  end
end
