class PicturesController < ApplicationController

  def index

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(
      url: params[:picture][:url],
      description: params[:picture][:description],
      rating: params[:picture][:rating]
    )
    if @picture.save
      redirect_to picture_path(@picture), notice: "Picture successfully created"
    else
      render new_picture_path
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end
end