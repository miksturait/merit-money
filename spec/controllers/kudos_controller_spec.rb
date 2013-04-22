require 'spec_helper'

describe KudosController do
  describe "giving one kudo" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @simon = create(:user, name: 'Simon', email: 'simon@selleo.com')
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')

      post :create, kudo: { receiver_id: @tom.id }
    end

    let(:bart_kudo) { @bart.kudos.last }
    it { expect(bart_kudo.value).to eq(1) }

    let(:bart_weekly_kudo) { @bart.current_weekly_kudo }
    it { expect(bart_weekly_kudo.kudos_left).to eq(19) }

    it { expect(@tom).to have(1).kudos_received }
  end

end
