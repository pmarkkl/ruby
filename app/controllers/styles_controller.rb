class StylesController < ApplicationController
  def index
    @styles = Style.all
  end

  def show
    @style = Style.find_by(id: params[:id])
  end
end
