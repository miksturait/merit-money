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
                                               kudos_total_received: 57,
                                               trend: 'steady'
                                           }.stringify_keys}.stringify_keys) }
  end

  describe "users list" do
    before do
      @tom = create(:user, name: 'Tom', email: 'tom@selleo.com')
      @simon = create(:user, name: 'Simon', email: 'simon@selleo.com')
      @radek = create(:user, name: 'Radek', email: 'radek@selleo.com')
      @current_user = create(:user, name: 'Bart', email: 'bart@selleo.com')

      @kudo = @current_user.thanks_to_user(@simon, {value: 5, comment: 'Thanks :-)'})
    end

    context "index" do
      before do
        get :index
      end

      let(:response_object) { JSON.parse(response.body) }
      let(:users_hash) {
        {
            "users" => [{"id" => @tom.id, "name" => "Tom", "email" => "tom@selleo.com",
                         "kudo_received_ids" => [], "kudo_last_week_ids" => []},
                        {"id" => @simon.id, "name" => "Simon", "email" => "simon@selleo.com",
                         "kudo_received_ids" => [@kudo.id], "kudo_last_week_ids" => []},
                        {"id" => @radek.id, "name" => "Radek", "email" => "radek@selleo.com",
                         "kudo_received_ids" => [], "kudo_last_week_ids" => []}],
            "kudo_receiveds" => [{"comment" => "Thanks :-)", "id" => @kudo.id, "receiver_id" => @simon.id, "value" => 5}],
            "kudo_last_weeks" => []
        }
      }

      it { expect(response_object).to eq(users_hash) }
    end

    context "show" do
      before do
        get :show, id: @simon.id
      end

      let(:response_object) { JSON.parse(response.body) }
      let(:user_hash) {
        {
            "user" => {"id" => @simon.id, "name" => "Simon", "email" => "simon@selleo.com",
                       "kudo_received_ids" => [@kudo.id], "kudo_last_week_ids" => []},
            "kudo_receiveds" => [{"comment" => "Thanks :-)", "id" => @kudo.id, "receiver_id" => @simon.id, "value" => 5}],
            "kudo_last_weeks" => []
        }
      }

      it { expect(response_object).to eq(user_hash) }

    end
  end
end
