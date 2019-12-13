class GratefulRemindersController < ApplicationController
  def index
    @grateful_reminders = GratefulReminder.all.order({ :created_at => :desc })

    render({ :template => "grateful_reminders/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @grateful_reminder = GratefulReminder.where({:id => the_id }).at(0)

    render({ :template => "grateful_reminders/show.html.erb" })
  end

  def create
    @grateful_reminder = GratefulReminder.new
    @grateful_reminder.user_id = params.fetch("user_id_from_query")
    @grateful_reminder.message_sent = params.fetch("message_sent_from_query")

    if @grateful_reminder.valid?
      @grateful_reminder.save
      redirect_to("/grateful_reminders", { :notice => "Grateful reminder created successfully." })
    else
      redirect_to("/grateful_reminders", { :notice => "Grateful reminder failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @grateful_reminder = GratefulReminder.where({ :id => the_id }).at(0)

    @grateful_reminder.user_id = params.fetch("user_id_from_query")
    @grateful_reminder.message_sent = params.fetch("message_sent_from_query")

    if @grateful_reminder.valid?
      @grateful_reminder.save
      redirect_to("/grateful_reminders/#{@grateful_reminder.id}", { :notice => "Grateful reminder updated successfully."} )
    else
      redirect_to("/grateful_reminders/#{@grateful_reminder.id}", { :alert => "Grateful reminder failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @grateful_reminder = GratefulReminder.where({ :id => the_id }).at(0)

    @grateful_reminder.destroy

    redirect_to("/grateful_reminders", { :notice => "Grateful reminder deleted successfully."} )
  end
end
