module ::Notifiable
  extend ActiveSupport::Concern

  def notify_fail(message: nil, params: nil, resource: nil, errors: [])
    notify({ message: message, params: params, resource: resource, errors: errors }, :excepetion)
  end

  def notify_event(message: nil, params: nil, resource: nil, extra_infos: [])
    notify({ message: message, params: params, resource: resource, extra_infos: extra_infos }, :event)
  end

  private

  def notify(params, kind)
    if kind.eql?(:event)
      Sentry.capture_message(params)
    else
      Sentry.capture_exception(params[:message], [extra: { extra: params }])
    end
  rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
  end
end
