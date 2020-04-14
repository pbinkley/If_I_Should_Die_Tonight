class ItemsController < ApplicationController
  def index
    @items = Item.paginate(page: params[:page], per_page: 50)
  end

  def charts
    @items = Item.where('location = "Buffalo, New York" OR location = "San Francisco, California"')
  end

  def show
    @item = Item.find(params[:id])
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
    # @item.thumbnail.attach(item_params[:thumbnail])

    @item.category_id = params[:category_id]
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end

    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.category_id = params[:category_id]

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:filename, :publication, :location, :date, :page, :url, :thumbnail)
  end
end
