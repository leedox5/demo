class HomeController < ApplicationController
  def index
    @recent_posts = Post.includes(:user, comments: :user).order(created_at: :desc).limit(3)
  end

  def message
    render partial: "message", locals: {
      message: "Turbo Frame으로 이 영역만 바뀌었습니다."
    }
  end
end
