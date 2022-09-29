# Esse arquivo e padrao do time WEB, portanto foi apenas trazido de outros lugares
module ApiCommonResponses
  extend ActiveSupport::Concern

  def render_success(data = {})
    render json: data, status: :ok
  end

  def render_created(data = {})
    render json: data, status: :created
  end

  def render_not_found
    head :not_found
  end

  def render_unauthorized
    head :unauthorized
  end

  def render_no_content
    head :no_content
  end

  def render_forbidden
    head :forbidden
  end

  def render_unprocessable_entity(resource = nil)
    data = parsed_error(resource)
    render json: data, status: :unprocessable_entity
  end

  def render_paginated_list(pagy:, data: [])
    render_success({ data: data, pagy: parsed_pagy(pagy) })
  end

  private

  def parsed_error(resource)
    { errors: resource }
  end

  def parsed_pagy(pagy)
    {
      count: pagy.count,
      pages: pagy.pages,
      page: pagy.page,
      next: pagy.next,
      prev: pagy.prev,
      items: pagy.items
    }
  end
end
