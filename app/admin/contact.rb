ActiveAdmin.register Contact do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :data, :_destroy
 actions :index, :show, :new, :create, :update, :edit, :destroy
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form title: 'Contact Page fields and values' do |f|
    inputs 'Details' do
      input :name
      input :data
    end
    f.actions
  end
end
