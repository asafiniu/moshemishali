class VideosController < ApplicationController
  before_filter :verify_admin, :only => [:index]

  @@ADMIN_PASS = "44353261"

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all.select{|v| v.is_visible and v.is_valid}

    respond_to do |format|
      format.html { render :layout => false } #index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id]) 

    respond_to do |format|
      format.html { render :layout => false } #show.html.erb
      format.json { render json: @video } 
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html { render :layout => false } # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new", :layout => false }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to "/videos?p=" + @@ADMIN_PASS }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    # @video.destroy

    @video.is_visible = false

    respond_to do |format|
      if @video.save
        format.html { redirect_to "/videos?p=" + @@ADMIN_PASS }
        format.json { render json: {:video => @video.to_json}  }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def verify_admin
    if params[:p] != @@ADMIN_PASS
      redirect_to :root
    end
  end
end
