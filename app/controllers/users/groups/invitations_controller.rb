class InvitationsController < Users::Groups::ApplicationController
  def create
    @affiliated_group = @group.build(invitation_params)
    if @affiliated_group.save
      redirect_to users_group_path(@group), notice: 'グループに招待しました'
    else
      flash[:alert] = '招待に失敗しました'
    end
  end

  private

  def invitation_params
    params.require(:group).permit(:user_id)
  end
end
