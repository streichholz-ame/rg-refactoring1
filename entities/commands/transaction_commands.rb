class TransactionCommands
  include ConsoleHelper
  include DataLoader
  include Validation

  attr_accessor :main_console, :current_account

  def initialize(console)
    @main_console = console
  end

  def update_current_account(current_account)
    @current_account = current_account
  end

  def withdraw_money
    cards_to_store = []
    output_message('common.choose_card_withdrawing')
    current_card = find_card(current_account)
    return unless current_card

    return unless MoneyOperations.withdraw_operation(current_card, user_input('common.withdraw_amount').to_i)

    cards_to_store.push current_account

    save_cards_data(cards_to_store)
  end

  def put_money
    cards_to_store = []
    output_message('common.choose_card')
    current_card = find_card(current_account)
    return unless current_card

    return unless MoneyOperations.put_operation(current_card, user_input('common.input_amount').to_i)

    cards_to_store.push current_account

    save_cards_data(cards_to_store)
  end

  def send_money
    cards_to_store = []
    output_message('common.choose_card_sending')
    sender_card = find_card(current_account)
    recipient_card = find_card_number

    return unless recipient_card && sender_card

    return unless MoneyOperations.send_operation(sender_card, recipient_card, user_input('common.withdraw_amount').to_i)

    cards_to_store.push current_account

    save_cards_data(cards_to_store)
  end
end
