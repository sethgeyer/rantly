class SessionsController < ApplicationController

  skip_before_action :ensure_current_user, only: [:index, :new]

  def index

  end

  def new

  end

end