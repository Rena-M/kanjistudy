class KanjisController < ApplicationController
  before_action :set_kanji, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  # GET /kanjis
  # GET /kanjis.json
  def index
    @letters = Letter.all.page(params[:page]).per(20)
    @lists = []
    if user_signed_in?
      current_user.kanjis.each do |kanji|
        kanji.letters.each do |letter|
          @lists << letter.id
        end
      end
    end
  end

  # GET /kanjis/1
  # GET /kanjis/1.json
  def show
    @letters = @kanji.letters
  end

  # GET /kanjis/new
  def new
    @kanji = Kanji.new
  end

  # GET /kanjis/1/edit
  def edit
  end

  # POST /kanjis
  # POST /kanjis.json
  def create
    @kanji = Kanji.new(kanji_params)
    @kanji.word = GoogleCloudVision.new(@kanji.image.file.file).request
    @kanji.update(Dejizo.new(@kanji.word).request)
    @kanji.user_id = current_user.id
    @kanji.save

    @image = Exif.new(params[:kanji][:image].tempfile)
    @kanji.taken_at = @image[:taken_at]
    @kanji.latitude = (@image[:latitude].to_f / 10000)
    @kanji.longitude = (@image[:longitude].to_f / 100)
    @kanji.save

    num = @kanji.word.length - 1
    while true
      break if num == 0
      if (letters = Letter.where(letter: @kanji.word[@kanji.word.length - 1 - num])).exists?
        @letter = letters.first
        KanjiLetter.create(kanji_id: @kanji.id, letter_id: @letter.id)
      end
      num -= 1
    end

    respond_to do |format|
      if @kanji.save
        format.html { redirect_to @kanji, notice: 'Kanji was successfully created.' }
        format.json { render :show, status: :created, location: @kanji }
      else
        format.html { render :new }
        format.json { render json: @kanji.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kanjis/1
  # PATCH/PUT /kanjis/1.json
  def update
    respond_to do |format|
      if @kanji.update(kanji_params)
        format.html { redirect_to @kanji, notice: 'Your photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @kanji }
      else
        format.html { render :edit }
        format.json { render json: @kanji.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kanjis/1
  # DELETE /kanjis/1.json
  def destroy
    @kanji.destroy
    respond_to do |format|
      format.html { redirect_to kanjis_url, notice: 'Your photo was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanji
      @kanji = Kanji.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kanji_params
      params.require(:kanji).permit(:image, :comment)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end
end
