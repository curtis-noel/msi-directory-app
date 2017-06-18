# Admin features
class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @model_list = ActiveRecord::Base.connection.tables

    # Loop through Model list, find schema_migrations and remove it
    @model_list.each_with_index do |name, index|
      @model_list.delete_at(index) if name == 'schema_migrations'
    end
  end
end
