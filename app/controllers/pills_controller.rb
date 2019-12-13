class PillsController < ApplicationController
  def index
    @pills = current_user.pills

    render({ :template => "pills/index.html.erb" })
  end


  def show
    the_id = params.fetch("id_from_path")
    @pill = Pill.where({:id => the_id }).at(0)

    render({ :template => "pills/show.html.erb" })
  end

  def create
    @pill = Pill.new
    @pill.user_id = current_user.id
    @pill.name = params.fetch("name_from_query")
    @pill.pill_time = params.fetch("pill_time_from_query")
    @pill.description = params.fetch("description_from_query")

    mg_api = '9ea18810c2824983caa303781a07e0f6-5645b1f9-ad0ea5db'
    mg_domain = 'sandboxad1c67663ede40459543964fd2dd9240.mailgun.org'
    mg_client = Mailgun::Client.new(mg_api)
    message_params = {:from => 'jleeny0@gmail.com',
                      :to => current_user.email,
                      :subject => 'Pill Time Reminder',
                      :text => 'Its time to take your pill! Please take your ' + @pill.name.to_s + " pill at" + @pill.pill_time.to_s}
                      
    mg_client.send_message(mg_domain, message_params)

    if @pill.valid?
      @pill.save
      redirect_to("/pills", { :notice => "Pill created successfully." })
    else
      redirect_to("/pills", { :notice => "Pill failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @pill = Pill.where({ :id => the_id }).at(0)

    @pill.user_id = params.fetch("user_id_from_query")
    @pill.name = params.fetch("name_from_query")
    @pill.pill_time = params.fetch("pill_time_from_query")
    @pill.description = params.fetch("description_from_query")

    if @pill.valid?
      @pill.save
      redirect_to("/pills/#{@pill.id}", { :notice => "Pill updated successfully."} )
    else
      redirect_to("/pills/#{@pill.id}", { :alert => "Pill failed to update successfully." })
    end
  end

  def delete_pill
    the_id = params.fetch("id_from_path")
    @pill = Pill.where({ :id => the_id }).at(0)

    @pill.destroy

    respond_to do |format|
      format.html {redirect_to(pills_url)}
      format.xml { head :no_content}
    end
  end

  # DELETE /pills/1
  # DELETE /appointments/1.json
  def destroy
    the_id = params.fetch("id_from_path")
    @pill = Pill.where({ :id => the_id }).at(0)
    @pill.destroy

    respond_to do |format|
      format.html {redirect_to(pills_url)}
      format.xml { head :no_content}
    end
  end
end
