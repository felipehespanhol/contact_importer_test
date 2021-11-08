class ImportsController < ApplicationController
  def index
    @imports = Import.all
  end

  def new
    @import = Import.new
  end

  def create
  end
end
