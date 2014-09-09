#encoding: utf-8
class LikesController < ApplicationController
  before_filter :check_user, :except => [:get_product_like, :get_brand_like]

  def index
  end

  def get_product_like
    rlt = {}
    if params[:product_id] != nil
      @product = Product.where(:product_id => params[:product_id]).first_or_create
      rlt[:status] = 1
      rlt[:likes] = @product.like_count
    else
      rlt[:status] = 0
      rlt[:msg] = "상품이 존재하지 않습니다."
    end
    render :json => rlt.to_json
  end
  
  def get_brand_like
    rlt = {}
    if params[:brand_id] != nil
      @brand = Brand.where(:brand_id => params[:brand_id]).first_or_create
      rlt[:status] = 1
      rlt[:likes] = @brand.like_count
    else
      rlt[:status] = 0
      rlt[:msg] = "상품이 존재하지 않습니다."
    end
    render :json => rlt.to_json
  end

	def like_product
    rlt = {}
    @product = Product.where(:product_id => params[:product_id]).first_or_create
    # check duplicate
    @product_like = UserProductLike.where(:user_id => @user.user_id, :product_id => @product.product_id).first
    if @product_like == nil
      if UserProductLike.create(:user_id => @user.user_id, :product_id => @product.product_id) and @product.increment!(:like_count)
        rlt[:status] = 1
        rlt[:likes] = @product.like_count
      else
        rlt[:status] = 0
        rlt[:likes] = @product.like_count
        rlt[:msg] = "오류가 발생했습니다."
      end
    else
      rlt[:status] = 0
      rlt[:likes] = @product.like_count
      rlt[:msg] = "이미 좋아요를 누르셨습니다."
    end
    render :json => rlt.to_json
	end
  
  def like_brand
    rlt = {}
    @brand = Brand.where(:brand_id => params[:brand_id]).first_or_create
    # check duplicate
    @brand_like = UserBrandLike.where(:user_id => @user.user_id, :brand_id => @brand.brand_id).first
    if @brand_like == nil
      if UserBrandLike.create(:user_id => @user.user_id, :brand_id => @brand.brand_id) and @brand.increment!(:like_count)
        rlt[:status] = 1
        rlt[:likes] = @brand.like_count
      else
        rlt[:status] = 0
        rlt[:likes] = @brand.like_count
        rlt[:msg] = "오류가 발생했습니다."
      end
    else
      rlt[:status] = 0
      rlt[:likes] = @brand.like_count
      rlt[:msg] = "이미 좋아요를 누르셨습니다."
    end
    render :json => rlt.to_json
  end
end
