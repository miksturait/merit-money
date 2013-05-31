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
      @rafal = create(:user, name: 'Rafal', email: 'rafal@selleo.com', retired: true)
      @current_user = create(:user, name: 'Bart', email: 'bart@selleo.com')
      Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))

      @tom_last_week_one = @current_user.thanks_to_user(@tom, {value: 2})
      @simon_last_week_one = @current_user.thanks_to_user(@simon, {value: 1})
      @tom_last_week_two = @current_user.thanks_to_user(@tom, {value: 2})
      @simon_last_week_two = @current_user.thanks_to_user(@simon, {value: 1})

      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))

      @kudo = @current_user.thanks_to_user(@simon, {value: 5, comment: 'Thanks :-)'})
    end

    after do
      Timecop.return
    end

    context "index" do
      before do
        get :index
      end

      let(:response_object) { JSON.parse(response.body) }
      let(:users_hash) {
        {
            "users" => [{"id" => @radek.id, "name" => "Radek", "email" => "radek@selleo.com",
                         "kudo_received_ids" => [], "kudo_last_week_ids" => []},
                        {"id" => @simon.id, "name" => "Simon", "email" => "simon@selleo.com",
                         "kudo_received_ids" => [@kudo.id],
                         "kudo_last_week_ids" => [@simon_last_week_two.id, @simon_last_week_one.id]},
                        {"id" => @tom.id, "name" => "Tom", "email" => "tom@selleo.com",
                         "kudo_received_ids" => [],
                         "kudo_last_week_ids" => [@tom_last_week_two.id, @tom_last_week_one.id]}
            ],
            "kudo_receiveds" => [
                {"comment" => "Thanks :-)", "id" => @kudo.id, "receiver_id" => @simon.id, "value" => 5}],
            "kudo_last_weeks" => [
                {"comment" => nil, "id" => @simon_last_week_two.id, "receiver_id" => @simon.id, "value" => 1},
                {"comment" => nil, "id" => @simon_last_week_one.id, "receiver_id" => @simon.id, "value" => 1},
                {"comment" => nil, "id" => @tom_last_week_two.id, "receiver_id" => @tom.id, "value" => 2},
                {"comment" => nil, "id" => @tom_last_week_one.id, "receiver_id" => @tom.id, "value" => 2}
            ]
        }
      }

      it { expect(response_object).to eq(users_hash) }
    end
  end
end
