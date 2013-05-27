require 'spec_helper'

describe CommentsController do

  let!(:tom) { create(:user, name: 'Tom', email: 'tom@selleo.com') }
  let!(:simon) { create(:user, name: 'Simon', email: 'simon@selleo.com') }
  let!(:bart) { create(:user, name: 'Bart', email: 'bart@selleo.com') }

  after do
    Timecop.return
  end

  before do
    Timecop.freeze(Time.parse('2013-02-20 13:15 UTC'))

    tom.thanks_to_user(bart, {value: 5, comment: 'this presentation in Paris was awesome'})
    simon.thanks_to_user(bart, {value: 1, comment: 'great job on metreno'})
    tom.thanks_to_user(simon, {value: 2, comment: 'for running'})
    bart.thanks_to_user(tom, {value: 2, comment: 'for the icecream'})

    Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))
  end

  describe "my comments" do
    before do
      get :my
    end

    let(:response_object) { JSON.parse(response.body) }

    it { expect(response_object).
        to eq({
                  "my_comments" => [
                      {"value" => 1, "comment" => "great job on metreno"},
                      {"value" => 5, "comment" => "this presentation in Paris was awesome"}
                  ]
              }) }

  end

  describe "others comments" do
    before do
      get :other
    end

    let(:response_object) { JSON.parse(response.body) }

    it { expect(response_object).
        to eq({
                  "other_comments" => [
                      {"value" => 2, "comment" => "for the icecream"},
                      {"value" => 2, "comment" => "for running"}
                  ]
              }) }
  end
end
