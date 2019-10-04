PASSWORD = 123456

emails = %w[nikita@mail.com bill@mail.com josh@mail.com kate@mail.com karen@mail.com]

tasks = ['refactoring', 'make a feature', 'rest a while', 'drink coffee', 'attend meeting', 'have a break']

comments = ['Hard tasks', 'An easy tasks', 'Good one..', 'Nicely done']

attachment_names = %w[ricardo.jpg doc.txt doc.pdf]

emails.each do |mail|
  User.create(
    email: mail,
    password: PASSWORD,
    role: User.roles.values.sample
  )
end

comments.each do |comment|
  Comment.find_or_create_by(
    body: comment,
    user_id: User.all.ids.sample
  )
end

tasks.each do |task|
  Task.find_or_create_by(
    title: task,
    start_date: Time.now,
    end_date: Time.now
  )
end

Task.all.each do |task|
  User.all.sample(2).each { |user| task.add_assignee(user) }
  task.add_creator(User.all.sample)
  task.status = Task.statuses.values.sample
  task.save
end

attachment_names.each do |attachment|
  Attachment.find_or_create_by(
    name: attachment,
    user_id: User.all.sample
  )
end

Attachment.all.each do |attachment|
  Task.all.sample.attachments << attachment
end

admin = User.find(1)
admin.admin!
admin.save
