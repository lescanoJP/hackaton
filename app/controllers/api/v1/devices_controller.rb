class Api::V1::DevicesController < Api::ApiController
  before_action :authenticate_user_from_token!

  def create
    device = Devices::CreateService.call(pushable: current_user, device_params: device_params)
    if device.success?
      render_success(device.result)
    else
      render_unprocessable_entity(device.error)
    end
  end

  private

  def device_params
    params.permit(:token, :platform)
  end

end
