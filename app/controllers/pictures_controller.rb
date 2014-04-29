class PicturesController < ApplicationController

  def index

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(
      url: params[:picture][:url],
      description: params[:picture][:description],
      rating: params[:picture][:rating]
    )
    redirect_to picture_path(@picture), notice: "Picture successfully created"
  end

  def show
    @picture = Picture.find(params[:id])
  end
end