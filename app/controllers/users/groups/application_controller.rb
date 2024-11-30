class Users::Groups::ApplicationController < Users::ApplicationController
  before_action :set_group

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
