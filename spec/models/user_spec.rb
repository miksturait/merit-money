require 'spec_helper'

describe User do

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:with_company_since).of_type(:date) }
  it { should have_db_column(:days_off_left).of_type(:integer) }

  it { should have_many(:kudos).through(:weekly_kudos) }
  it { should have_many(:kudos_received).class_name("Kudo") }


  context "weekly kudo for current week" do
    let(:tom) { create(:user, name: 'Tom') }
    let!(:weekly_kudo) { WeeklyKudo.current(tom) }

    it { expect(weekly_kudo).to eq(tom.current_weekly_kudo) }
  end

  describe "kudos that have been received in current week from current_user" do
    after do
      Timecop.return
    end

    let(:tom) { create(:user, name: 'Tom', email: 'tom@selleo.com') }
    let(:bart) { create(:user, name: 'Bart', email: 'bart@selleo.com') }

    let(:current_user) { create(:user, name: 'Simon', email: 'simon@selleo.com') }

    before do
      # give some kudos two weeks back
      Timecop.freeze(Time.parse('2013-02-20 13:15 UTC'))
      current_user.thanks_to_user(tom, {value: 3, comment: 'this is old'})
      current_user.thanks_to_user(bart, {value: 1, comment: 'this is also old'})

      # give some kudos in last week
      Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))
      current_user.thanks_to_user(tom, {value: 4, comment: 'this is from last week'})
      current_user.thanks_to_user(bart, {value: 7, comment: 'this is from last Thursday'})
      current_user.thanks_to_user(tom, {value: 2, comment: 'this is from last Friday'})

      Timecop.freeze(Time.parse('2013-03-04 13:15 UTC'))
      # give some kudos in current week
      current_user.thanks_to_user(tom, {value: 3, comment: 'this is from today'})

    end


    let(:previous_week) { Week.previous }
    context "last week kudos" do
      let(:last_week_kudos_for_tom) { tom.kudos_given_by_user_in_week(current_user, previous_week) }
      let(:last_week_kudos_value_for_tom) { last_week_kudos_for_tom.sum(&:value) }

      it { expect(last_week_kudos_for_tom).to have(2).items }
      it { expect(last_week_kudos_value_for_tom).to eq(6) }

      let(:last_week_kudos_for_bart) { bart.kudos_given_by_user_in_week(current_user, previous_week) }
      let(:last_week_kudos_value_for_bart) { last_week_kudos_for_bart.sum(&:value) }

      it { expect(last_week_kudos_for_bart).to have(1).item }
      it { expect(last_week_kudos_value_for_bart).to eq(7) }
    end

    let(:week) { Week.current }
    context "current week kudos" do
      let(:current_week_kudos_for_tom) { tom.kudos_given_by_user_in_week(current_user, week) }
      let(:current_week_kudos_value_for_tom) { current_week_kudos_for_tom.sum(&:value) }

      it { expect(current_week_kudos_for_tom).to have(1).item }
      it { expect(current_week_kudos_value_for_tom).to eq(3) }

      let(:current_week_kudos_for_bart) { bart.kudos_given_by_user_in_week(current_user, week) }
      let(:current_week_kudos_value_for_bart) { current_week_kudos_for_bart.sum(&:value) }

      it { expect(current_week_kudos_for_bart).to be_empty }
      it { expect(current_week_kudos_value_for_bart).to eq(0) }
    end
  end

  describe "received comments" do
    after do
      Timecop.return
    end

    let(:tom) { create(:user, name: 'Tom', email: 'tom@selleo.com') }
    let(:simon) { create(:user, name: 'Simon', email: 'simon@selleo.com') }
    let(:bart) { create(:user, name: 'Bart', email: 'bart@selleo.com') }

    before do
      Timecop.freeze(Time.parse('2013-02-20 13:15 UTC'))

      tom.thanks_to_user(bart, {value: 5, comment: 'this presentation in Paris was awesome'})
      simon.thanks_to_user(bart, {value: 1, comment: 'great job on metreno'})
      tom.thanks_to_user(simon, {value: 2, comment: 'for running'})
      bart.thanks_to_user(tom, {value: 2, comment: 'for the icecream'})
      tom.thanks_to_user(simon, {value: 3, comment: 'for sks app'})

      # it should't include comments from current week
      Timecop.freeze(Time.parse('2013-02-27 13:15 UTC'))

      simon.thanks_to_user(bart, {value: 2, comment: 'pair programming was awesome'})
      tom.thanks_to_user(simon, {value: 3, comment: 'learning patters is awesome'})
    end

    context "my comments" do
      it { expect(bart).to have(2).latest_comments }

      let(:last_comment) { bart.latest_comments.first }

      it { expect(last_comment).to eq({value: 1, comment: 'great job on metreno'}) }
    end

    context "other comments" do
      it { expect(bart).to have(3).latest_other_comments }

      let(:last_other_comment) { bart.latest_other_comments.first }

      it { expect(last_other_comment).to eq({value: 3, comment: 'for sks app'}) }
    end

  end
end
