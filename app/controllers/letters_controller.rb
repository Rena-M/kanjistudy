class LettersController < ApplicationController
  before_action :set_kanji, only: [:show]

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanji
      @letter = Letter.find(params[:id])
    end

end
