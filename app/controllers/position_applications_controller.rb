class PositionApplicationsController < ApplicationController

  before_filter :authorize_call_admin, except: [:new, :create, :show]
  before_filter :authorize_applicant, only: [:new, :create]
  before_filter { |c| c.find_call_from_current_university :call_id }
  before_filter :find_application_from_call, except: [:index, :new, :create]

  def index
  end

  def show
    respond_to do |format|
      format.fragment
    end
  end

  def new
    @position_application = @call.position_applications.build(user_id: @user._id, custom: {})
    respond_to do |format|
      format.fragment
    end
  end

  def edit
  end

  def create
    @call.position_applications.where(user_id: @user.id).destroy_all if @call.position_applications.where(user: @user).exists?
    @position_application = @call.position_applications.build position_application_param
    @position_application.deputy =  PositionApplication.find(deputy_id_param) if deputy_id_param.present?
    if @position_application.save
      if send_reminder_switch_param && send_reminder_switch_param == "yes" && reminder_email_param.present?
        ApplicationMailer::EmailNotificationJob.new.async.perform(@position_application.id, @university.id, reminder_email_param)
      end
      render "create"
    else
      render "new"
    end
  end

  def update
    @position_application.update_attributes! position_application_param
    respond_to do |format|
      format.json { render :json => @position_application }
    end
  end

  def destroy
  end

  protected

  def find_application_from_call
    @position_application = @call.position_applications.find(id_param)
  end


  private

  def position_application_param
    params.require(:position_application).permit(:user_id, :position, :deputy_of, :personal_statement)
  end

  def deputy_id_param
    params.require(:position_application).permit(:deputy_id)
  end

  def send_reminder_switch_param
    params.require(:position_application).permit(:send_reminder_switch)
  end

  def reminder_email_param
    params.require(:position_application).permit(:reminder_email)
  end

  def id_param
    params.permit(:id)
  end

end
