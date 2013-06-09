ActiveAdmin.register WeeklyKudo do
  index do
    column :trend
    column "User", sortable: 'users.name' do |weekly_kudo|
      weekly_kudo.user.name
    end
    column :kudos_left
    column "Total", :up_to_last_week_total_kudos_received
    column "Last Week", :last_week_kudos_received

    default_actions
  end

  controller do
    def scoped_collection
      resource_class.includes(:user)
    end
  end

end
