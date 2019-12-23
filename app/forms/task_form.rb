class TaskForm
  include ActiveModel::Model
  include ActiveModel::Dirty
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
    send_mail
    @task.update!(attributes)
  end

  def create_task
    @task = Task.create!(attributes)
    @task.set_creator(@current_user)
  end

  private

  def send_mail

    new_assigned_users = attributes[:user_ids] - @task.user_ids
    new_assigned_users-=['']
    #unassigned_users = @task.user_ids - user_ids
    if new_assigned_users.any?
      new_assigned_users.each do |user_id|
        user = User.find(user_id).username
        binding.pry
        TaskMailer.new_assignment_task_email(@task.title, user).deliver_now
      end
    end
  end

  def safe_merge(params, values)
    params.merge!(values&.attributes.to_h.reject { |key| params.keys.include? key })
  end
end
