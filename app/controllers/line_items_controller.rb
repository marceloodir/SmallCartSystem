class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = current_cart.line_items
    @cart = current_cart
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @line_item = LineItem.new(line_item_params)
    respond_to do |format|
      if add_line_item_to_cart
        format.html { redirect_to root_path, notice: 'Line item was successfully created.' }
      else
        format.html { redirect_to root_path, notice: 'Algo deu errado ao adicionar esse item.' }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    if line_item_params[:quantity].to_i <= 0
      destroy
    else
      respond_to do |format|
        if @line_item.update(line_item_params)
          format.html { redirect_to line_items_path, notice: 'Line item was successfully updated.' }
          format.json { render :index, status: :ok, location: line_items_path }
        else
          format.html { render :index }
          format.json { render json: line_items_path, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      #params.require(:line_item).permit(:cart_id, :product_id, :quantity)
      params.permit(:quantity,:product_id)
    end

    def add_line_item_to_cart
      current_line_items = current_cart.line_items
      line_item = current_line_items.find_by(product: @line_item.product)
      if line_item
        line_item.quantity = line_item.quantity + 1
        line_item.save
      else
        current_line_items << @line_item
      end
    end

end
