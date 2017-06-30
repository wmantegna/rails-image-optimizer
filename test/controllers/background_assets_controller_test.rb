require 'test_helper'

class BackgroundAssetsControllerTest < ActionController::TestCase
  setup do
    @background_asset = background_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:background_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create background_asset" do
    assert_difference('BackgroundAsset.count') do
      post :create, background_asset: { attachment_content_type: @background_asset.attachment_content_type, attachment_file_name: @background_asset.attachment_file_name, attachment_file_size: @background_asset.attachment_file_size, attachment_height: @background_asset.attachment_height, attachment_processing: @background_asset.attachment_processing, attachment_width: @background_asset.attachment_width, filesize_metadata: @background_asset.filesize_metadata }
    end

    assert_redirected_to background_asset_path(assigns(:background_asset))
  end

  test "should show background_asset" do
    get :show, id: @background_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @background_asset
    assert_response :success
  end

  test "should update background_asset" do
    patch :update, id: @background_asset, background_asset: { attachment_content_type: @background_asset.attachment_content_type, attachment_file_name: @background_asset.attachment_file_name, attachment_file_size: @background_asset.attachment_file_size, attachment_height: @background_asset.attachment_height, attachment_processing: @background_asset.attachment_processing, attachment_width: @background_asset.attachment_width, filesize_metadata: @background_asset.filesize_metadata }
    assert_redirected_to background_asset_path(assigns(:background_asset))
  end

  test "should destroy background_asset" do
    assert_difference('BackgroundAsset.count', -1) do
      delete :destroy, id: @background_asset
    end

    assert_redirected_to background_assets_path
  end
end
