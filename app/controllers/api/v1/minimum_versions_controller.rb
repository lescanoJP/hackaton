class Api::V1::MinimumVersionsController < Api::ApiController
  def index
    minimum_version = MinimumVersion.order(:updated_at).where(minimum_version_params).last

    return render_success(minimum_version) if minimum_version.present?

    render_no_content
  end

  private

  def minimum_version_params
    params.permit(:platform)
  end

end
