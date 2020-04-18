class ItemsController < ApplicationController
  def index
    @items = Item.paginate(page: params[:page], per_page: 50)
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def charts
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def new
    @item = Item.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def edit
    @item = Item.find(params[:id])
    @item.category_id = 1 unless @item.category_id
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to @item }
        format.js
        format.json { render :show, status: :ok, location: @item }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:filename, :publication, :location, :date, :page, :url, :thumbnail, :category_id)
  end
end
