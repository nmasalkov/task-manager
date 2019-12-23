class TaskForm
  include ActiveModel::Model
  include Virtus

  attr_accessor :task

  attribute :id, Integer
  attribute :creator_id, Integer
  attribute :creator_name, String
  attribute :status, String
  attribute :description, String
  attribute :start_date, DateTime
  attribute :end_date, DateTime
  attribute :title, String
  attribute :user_ids, Array(Integer)

  def initialize(current_user, params = {}, task = nil)
    @current_user = current_user
    @task = task
    params.merge!(user_ids: task&.user_ids) unless params[:user_ids].present?
    safe_merge(params, task)
    super(params)
  end

  def model_name
    ActiveModel::Name.new(self, nil, Task.to_s)
  end

  def persisted?
    !@task.nil?
  end

  def creator
    @task.creator
  end

  def save
    if !persisted?
      create_task
    else
      update_task
    end
  end

  def update_task
    @task.update!(attributes)
  end

  def create_task
    @task = Task.create!(attributes)
    @task.set_creator(@current_user)
  end

  private

  def safe_merge(params, values)
    params.merge!(values&.attributes.to_h.reject { |key| params.keys.include? key })
  end
end
