class HomeController < ApplicationController
  def index
  end

  def message
    render partial: "message", locals: {
      message: "Turbo Frame으로 이 영역만 바뀌었습니다."
    }
  end
end
