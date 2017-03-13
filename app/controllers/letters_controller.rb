class LettersController < ApplicationController
  before_action :set_kanji, only: [:show]

  def show
    @kanjis = @letter.kanjis
    @lists = []
    if user_signed_in?
      current_user.kanjis.each do |kanji|
        kanji.letters.each do |letter|
          @lists << letter.id
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanji
      @letter = Letter.find(params[:id])
    end

end
