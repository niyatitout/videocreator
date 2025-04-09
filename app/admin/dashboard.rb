# app/admin/dashboard.rb

ActiveAdmin.register_page "Dashboard" do
  content title: proc { "Admin Dashboard" } do

    # Example 1: Quick Stats Section
    section "Quick Stats" do
      div class: "dashboard-cards" do
        span "Total Users: #{User.count}", class: "card"
        span "Videos: #{Video.count}", class: "card"
        span "Channels: #{Channel.count}", class: "card"
      end
    end

    # Example 2: Recent Signups
    section "Recent Users" do
      table_for User.order(created_at: :desc).limit(5) do
        column :email
        column :created_at
      end
    end

    # More panels, charts, etc...

  end
end
