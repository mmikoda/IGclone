class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: "minoru.mikoda@gmail.com", subject: "投稿完了メール"
  end
end
