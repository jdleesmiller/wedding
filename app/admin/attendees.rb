# frozen_string_literal: true

ActiveAdmin.register Attendee do
  scope :child?
  scope :diet?

  controller do
    def apply_sorting(chain)
      params[:order] ? chain : chain.reorder(last_name: :asc, first_name: :asc)
    end
  end

  index do
    column :first_name
    column :last_name
    column :email
    column :diet
    column :notes
    column :child
    column :updated_at
  end

  config.batch_actions = false
  config.filters = false
  config.per_page = 500
  config.clear_action_items!
end
