# frozen_string_literal: true

class NormalizeDatesService
  def initialize(task_params)
    @task_params = task_params
  end

  def normalize_date_attr
    valid_start_date = DateTime.new(@task_params['start_date(1i)'].to_i,
                                    @task_params['start_date(2i)'].to_i,
                                    @task_params['start_date(3i)'].to_i,
                                    @task_params['start_date(4i)'].to_i,
                                    @task_params['start_date(5i)'].to_i)
    valid_end_date = DateTime.new(@task_params['end_date(1i)'].to_i,
                                  @task_params['end_date(2i)'].to_i,
                                  @task_params['end_date(3i)'].to_i,
                                  @task_params['end_date(4i)'].to_i,
                                  @task_params['end_date(5i)'].to_i)

    @task_params['start_date'] = valid_start_date
    @task_params['end_date'] = valid_end_date
    @task_params
  end
end
