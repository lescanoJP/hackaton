class AbstractModel::StatementBuilder
  # Nao salvar datas do tipo Date como DateTime (tempo zerado)
  def build_statement_for_datetime_or_timestamp
    start_date, end_date = get_filtering_duration

    start_date = current_timezone_to_utc(start_date.try(:beginning_of_day)) if start_date
    end_date = current_timezone_to_utc(end_date.try(:end_of_day)) if end_date

    range_filter(start_date, end_date)
  end

  def current_timezone_to_utc(date)
    ActiveSupport::TimeZone.new('Brasilia').local_to_utc(date) unless date.nil?
  end

end
