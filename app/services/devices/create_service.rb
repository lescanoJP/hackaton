class Devices::CreateService < BusinessProcess::Base
  needs :device_params
  needs :pushable

  steps :init,
        :find_device,
        :create_device,
        :update_user_platform

  def call
    process_steps
    @device
  end

  private

  def init
    @token = device_params[:token]
    @platform = device_params[:platform]
  end

  def find_device
    fail([I18n.t('devices.errors.blank')]) unless @token.present? && @platform.present?

    @device = JeraPush::Device.find_by(token: @token, platform: @platform)
  end

  def create_device
    if @device.blank?
      destroy_devices

      @device = JeraPush::Device.create(token: @token,
                                        platform: @platform,
                                        pushable_id: pushable.id)
    else
      update_device
    end
  end

  def destroy_devices
    pushable&.devices&.destroy_all
  end

  def update_device
    @device.update(pushable: pushable) unless pushable&.devices&.include? @device
  end

  def update_user_platform
    pushable.update(platform: @platform)
  end

end
