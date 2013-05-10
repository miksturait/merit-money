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
end
