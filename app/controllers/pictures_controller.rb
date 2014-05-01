class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
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

  def edit
    @picture = Picture.find(params[:id])

  end

  def update
    @picture = Picture.find(params[:id])
    @picture.url = params[:picture][:url]
    @picture.description = params[:picture][:description]
    @picture.rating = params[:picture][:rating]

    if @picture.save
      redirect_to picture_path(@picture)
    else
      redirect_to edit_picture_path(@picture), notice: "Field cannot be empty"
    end

  end
end