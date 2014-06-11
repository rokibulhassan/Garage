require 'spec_helper'

describe ComparisonTable do
  it "By default recent comparisons contains last 3 comparisons created" do
    user              = FactoryGirl.create(:user)
    very_old_table    = FactoryGirl.create(:comparison_table, user: user, created_at: 40.minutes.ago)
    old_table         = FactoryGirl.create(:comparison_table, user: user, created_at: 30.minutes.ago)
    recent_table      = FactoryGirl.create(:comparison_table, user: user, created_at: 20.minutes.ago)
    very_recent_table = FactoryGirl.create(:comparison_table, user: user, created_at: 10.minutes.ago)

    user.comparison_tables.recent.should == [ very_recent_table, recent_table, old_table ]
  end


  it "Explicitely recent comparisons contains last N comparisons created" do
    user           = FactoryGirl.create(:user)
    very_old_table = FactoryGirl.create(:comparison_table, user: user, created_at: 30.minutes.ago)
    old_table      = FactoryGirl.create(:comparison_table, user: user, created_at: 20.minutes.ago)
    recent_table   = FactoryGirl.create(:comparison_table, user: user, created_at: 10.minutes.ago)

    user.comparison_tables.recent(2).should == [ recent_table, old_table ]
  end


  it "should not be create without a user" do
    expect { ComparisonTable.create }.not_to change { ComparisonTable.count }
  end
end
