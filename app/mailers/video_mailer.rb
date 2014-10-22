class VideoMailer < ActionMailer::Base
  default from: '"Awesome Picture & Video" <hello@awesomepv.com>'

  def video_email(user)
    @user = user
    @video = @user.videos
    @url  = 'http://awesomepv.com/'
    mail(:to => "#{user.username} <#{user.email}>", :subject => "New Video Added!")
   end
end
