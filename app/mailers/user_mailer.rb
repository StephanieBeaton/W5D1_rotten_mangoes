class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  # Mailer creates a message to be delivered via email.

  # Mailers are really just another way to render a view.
  # Instead of rendering a view and sending out the HTTP protocol,
  # they are just sending it out through the email protocols instead.
  # Due to this, it makes sense to just have your controller tell the Mailer
  # to send an email when a user is successfully created.



  def account_deleted_notice_email(user)
    @user = user
    @url  = 'http://localhost:3000/movies'

    # any instance variables we define in the method
    # become available for use in the views.

    # When you call the mail method now,
    # Action Mailer will detect the two templates (text and HTML)
    # and automatically generate a multipart/alternative email.

    # actual mail template --
    #  app/views/user_mailer/welcome_email.html.erb


    # The method account_deleted_notice_email returns a ActionMailer::MessageDelivery object
    # which can then just be told deliver_now or deliver_later to send itself out.

    # returns ActionMailer::MessageDelivery object

    temp = mail(to: @user.email, subject: 'Your rottenmangoes.com account has been deleted.')

  end
end
