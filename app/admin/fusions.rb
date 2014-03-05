ActiveAdmin.register Fusion do
  show do |fusion|
    summary = {
        start_at: fusion.start_at,
        end_at: fusion.end_at,
        kudos_left: fusion.weekly_kudos.sum(:kudos_left),
        coworkers: WeeklyKudo.where(week_id: fusion.weeks.last).collect do |weekly_kudo|
          {
              email: weekly_kudo.user.email,
              kudos: weekly_kudo.up_to_last_week_total_kudos_received
          }
        end
    }
    render text: summary.to_json
  end
end
