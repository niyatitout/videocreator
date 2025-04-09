ActiveAdmin.register Channel do
  permit_params :name, :visibility, :description

  index do
    selectable_column
    id_column
    column :name
    column :visibility
    column :created_at
    actions
  end

  filter :name
  filter :visibility
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :visibility, as: :select, collection: ['public', 'private']
      f.input :description
    end
    f.actions
  end
end
