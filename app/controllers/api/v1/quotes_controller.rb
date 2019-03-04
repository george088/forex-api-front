class Api::V1::QuotesController < ApplicationController
  before_action :check_apikey
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.fetch(:quote, {})
    end

    def check_apikey
      render json: { message: 'Check key or create user', status: :unauthorized } if User.find_by(apikey: params[:key]).nil?
    end
end
