ActiveAdmin.register User do
  # 👇 Allow only specific attributes to be modified via the admin panel
  permit_params :email, :password, :password_confirmation

  # 👇 Display columns in index view
  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    actions
  end

  # 👇 Filters in the admin sidebar
  filter :email
  filter :created_at

  # 👇 Form for creating/editing users
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
