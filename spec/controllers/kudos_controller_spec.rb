require 'spec_helper'

describe KudosController do
  describe "giving one kudo" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @simon = create(:user, name: 'Simon', email: 'simon@selleo.com')
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')

      post :create, kudo: {receiver_id: @tom.id}
    end

    let(:response_object) { JSON.parse(response.body) }
    it { expect(response_object).to eq({"status" => "ok"}) }

    let(:bart_kudo) { @bart.kudos.last }
    it { expect(bart_kudo.value).to eq(1) }

    let(:bart_weekly_kudo) { @bart.current_weekly_kudo }
    it { expect(bart_weekly_kudo.kudos_left).to eq(19) }

    it { expect(@tom).to have(1).kudos_received }
  end

  describe "giving two kudo with the comment" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @simon = create(:user, name: 'Simon', email: 'simon@selleo.com')
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')

      post :create, kudo: {receiver_id: @tom.id, comment: "one :-)", value: 2}
    end

    let(:response_object) { JSON.parse(response.body) }
    it { expect(response_object).to eq({"status" => "ok"}) }

    let(:bart_kudo) { @bart.kudos.last }
    it { expect(bart_kudo.value).to eq(2) }
    it { expect(bart_kudo.comment).to eq('one :-)') }

    let(:bart_weekly_kudo) { @bart.current_weekly_kudo }
    it { expect(bart_weekly_kudo.kudos_left).to eq(18) }

    it { expect(@tom).to have(1).kudos_received }
  end

  context "giving kudo, when nothing lefts" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')
      @bart.current_weekly_kudo.update_attribute(:kudos_left, 0)

      post :create, kudo: {receiver_id: @tom.id, comment: "one :-)", value: 2}
    end

    let(:response_object) { JSON.parse(response.body) }
    it { expect(response_object).to eq({"status" => "error"}) }

    it { expect(@tom).to have(0).kudos_received }
  end

  context "giving the last kudo" do

    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')
      @bart.current_weekly_kudo.update_attribute(:kudos_left, 1)

      post :create, kudo: {receiver_id: @tom.id, comment: "one :-)", value: 1}
    end

    let(:response_object) { JSON.parse(response.body) }
    it { expect(response_object).to eq({"status" => "ok"}) }

    it { expect(@tom).to have(1).kudos_received }
  end


  describe "Comments" do
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

      get :index
    end

    let(:response_object) { JSON.parse(response.body) }

    it { expect(response_object).
        to eq({
                  "comments" => [
                      {"value" => 1, "comment" => "great job on metreno"},
                      {"value" => 5, "comment" => "this presentation in Paris was awesome"}
                  ]
              }) }

  end
end
