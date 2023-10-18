class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  def index
    @category = Category.find(params[:category_id])
    @payments = Payment.where(author_id: current_user.id, category_id: @category.id).order(created_at: :desc)
  end

  def new
    @category = Category.find(params[:category_id])
    @payment = @category.payments.build
  end

  def create
    @category = Category.find(params[:category_id])
    @payment = @category.payments.build(payment_params)
    @payment.author = current_user

    respond_to do |format|
      if @payment.save
        format.html { redirect_to category_payments_path(@category), notice: 'Payment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:name, :amount, :author_id, :category_id)
  end
end
