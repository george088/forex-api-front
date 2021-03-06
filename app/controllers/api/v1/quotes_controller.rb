class Api::V1::QuotesController < ApplicationController
  before_action :check_apikey
  before_action :current_user
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  # api/v1/quotes?key=?&ticket=?&type=(OHLC/close)&from=YYYY-mm-dd&to=YYYY-mm-dd
  # api/v1/quotes?key=?&ticket=?&type=(OHLC/close)&for_date=YYYY-mm-dd
  def show
    ticketlist = Ticketlist.tickets(@user.type_role)
    
    type = ['close']
    type = ['open', 'high', 'low', 'close'] if params[:type] == 'OHLC'
    
    return render json: {message: "You haven't access to #{params[:ticket]}. Only for premium" } if Ticketlist.find_by(ticket: params[:ticket]).premium <= @user.role
    render json: { data: Quote.quotes(ticketlist, type, params[:from], params[:to]), status: :ok }
  end

  # api/v1/quotes/tickets_list?key=?
  def tickets_list
    render json: {tiketlist: Ticketlist.tickets(@user.type_role), status: :ok}
  end

  # api/v1/quotes/avalable_dates?key=?&ticket=?
  def avalable_dates
    render json: {"avalable_dates_#{params[:ticket]}" => Quote.avalable_dates(params[:ticket]), status: :ok}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.where(params[:ticket])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.fetch(:quote, {})
    end

    # check apikey
    def check_apikey
      render json: { message: 'Check key or create user', status: :unauthorized } if User.find_by(apikey: params[:key]).nil?
    end

    def current_user
      @user = User.find_by(apikey: params[:key])
    end
end
