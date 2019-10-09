class NewTaskFormDry
  include ActiveModel::Model

  # include Dry.Struct

  attribute :title, String
  attribute :creator_id, Integer
  attribute :creator_name, String
  attribute :status, String
  attribute :description, String
  attribute :start_date, DateTime
  attribute :end_date, DateTime

  validates :title, presence: true

  def persisted?
    false
  end

  def new_record?
    true
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def editable?
    true
  end

  private

  def persist!
    @task = Task.create!(title: title,
                         creator_id: creator_id,
                         creator_name: creator_name,
                         status: status,
                         start_date: start_date,
                         end_date: end_date,
                         description: description)
  end
end