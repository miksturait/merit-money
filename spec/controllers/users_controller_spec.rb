require 'spec_helper'

describe UsersController do

  describe "current user information" do
    before do
      @bart = create(:user, name: 'Bart', email: 'bart@selleo.com')
      weekly_kudo = @bart.current_weekly_kudo
      weekly_kudo.update_attributes(kudos_left: 15,
                                    last_week_kudos_received: 13,
                                    up_to_last_week_total_kudos_received: 57)

      get :me
    end

    subject(:response_object) { JSON.parse(response.body) }

    it { expect(response_object).to eq({
                                           current_user: {
                                               id: @bart.id,
                                               name: 'Bart',
                                               email: 'bart@selleo.com',
                                               kudos_left: 15,
                                               kudos_received: 13,
                                               kudos_total_received: 57
                                           }.stringify_keys}.stringify_keys) }
  end

  describe "users list" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @simon = create(:user, name: 'Simon', email: 'simon@selleo.com')
      @radek = create(:user, name: 'Radek', email: 'radek@selleo.com')
      create(:user, name: 'Bart', email: 'bart@selleo.com')
      get :index
    end

    subject(:response_object) { JSON.parse(response.body) }

    let(:users_hash) { {:users => [@tom, @simon, @radek].map(&:ember_user_info).map(&:stringify_keys)}.stringify_keys }

    it { expect(response_object).to eq(users_hash) }

  end
end
