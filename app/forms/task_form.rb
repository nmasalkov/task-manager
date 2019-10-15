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
    binding.pry
    @current_user = current_user
    params.merge!(user_ids: task.user_ids)
    params.merge!(task&.attributes.to_h)
    binding.pry
    super(params)
    @task = task
  end

  def model_name
    ActiveModel::Name.new(self, nil, Task.to_s)
  end

  # def user_ids
  #   binding.pry
  #   if persisted?
  #     @task.user_ids
  #   else
  #     Task.new.user_ids
  #   end
  # end

  def persisted?
    id.present?
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
end
