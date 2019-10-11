class TaskForm
  include ActiveModel::Model
  include Virtus

  attr_accessor :task

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
    if task.present?
      @params = task.attributes
      @params.merge!(params)
      super(@params)
    else
      @params = params
      super(@params)
    end
    @task = task
  end

  def model_name
    ActiveModel::Name.new(self, nil, Task.to_s)
  end

  def user_ids
    if !new_record?
      @task.user_ids
    else
      Task.new.user_ids
    end
  end

  def new_record?
    @task.nil?
  end

  def creator
    @task.creator
  end

  def save
    if new_record?
      create_task
    else
      update_task
    end
  end

  def update_task
    @task.update!(@params)
  end

  def create_task
    @task = Task.create!(@params)
    @task.set_creator(@current_user)
  end
end
