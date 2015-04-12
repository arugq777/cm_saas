class ContactMailer < ActionMailer::Base
  default to: "zenhexy@fastmail.fm"
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body

    mail(from: @email, subject: 'Contact Email')
  end
end