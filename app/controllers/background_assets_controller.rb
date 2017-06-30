class BackgroundAssetsController < ApplicationController
  before_action :set_background_asset, only: [:show, :edit, :update, :destroy]

  # GET /background_assets
  def index
    @background_assets = BackgroundAsset.all
  end

  # GET /background_assets/1
  def show
  end

  # GET /background_assets/new
  def new
    @background_asset = BackgroundAsset.new
  end

  # GET /background_assets/1/edit
  def edit
  end

  # POST /background_assets
  def create
    @background_asset = BackgroundAsset.new(background_asset_params)

    if @background_asset.save
      redirect_to @background_asset, notice: 'Background asset was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /background_assets/1
  def update
    if @background_asset.update(background_asset_params)
      redirect_to @background_asset, notice: 'Background asset was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /background_assets/1
  def destroy
    @background_asset.destroy
    redirect_to background_assets_url, notice: 'Background asset was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_background_asset
      @background_asset = BackgroundAsset.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def background_asset_params
      params.require(:background_asset).permit(:attachment)
    end
end
