class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /links
  # GET /links.json
  def index
    @links = Link.all
    # Orders posts (Default is newst -> oldest) and sets paginate paramaters
    @links = Link.order("created_at DESC").paginate(page: params[:page], per_page: 10)

    if params[:search]
      @links = Link.where('title LIKE ?', "%#{params[:search]}%")
    end

  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @link = Link.find(params[:id])
    @link.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "thank you for voting"
  end

  def oldest
    @links = Link.all
    # Orders posts (Default is newst -> oldest) and sets paginate paramaters
    @links = Link.order("created_at ASC").paginate(page: params[:page], per_page: 10)

    if params[:search]
      @links = Link.where('title LIKE ?', "%#{params[:search]}%")
    end
  end

  def hottest
    @links = Link.all
    @links = Link.popular.paginate(page: params[:page], per_page: 10)

    if params[:search]
      @links = Link.where('title LIKE ?', "%#{params[:search]}%")
    end

  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'link was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Upvote action *BAD*
  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to links_path
  end

  # Downvote action *BAD*
  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to links_path
  end

  def snake
  end

  # Link orginization

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url)
    end

end
