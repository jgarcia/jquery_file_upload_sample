class PhotosController < ApplicationController
  before_filter :load_album
  # GET /photos
  # GET /photos.json
  def index
    @photos = @album.photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = @album.photos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = @album.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = @album.photos.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @album.photos.new(params[:photo])

    if @photo.save
      respond_to do |format|
        format.html {redirect_to album_photos_path(@album), notice: 'Photo was successfully created.'}
        @photos = [@photo]
        format.json {render 'index'}
      end
    else
      render 'new'
    end

    # respond_to do |format|
    #   if @photo.save
    #     format.html { redirect_to @album, notice: 'Photo was successfully created.' }
    #     format.json { render json: @photo, status: :created, location: album_photo_url(@album, @photo)}
    #     # format.json {status: :created}
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @photo.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = @album.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @album, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = @album.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to @album }
      format.json { head :no_content }
    end
  end
  
  private 
  def load_album
    @album = Album.find(params[:album_id])
  end
end
