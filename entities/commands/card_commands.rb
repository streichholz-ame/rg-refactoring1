class CardCommands
  include ConsoleHelper
  include DataLoader
  include Validation

  attr_accessor :current_account, :main_console

  def initialize(console)
    @main_console = console
    @file_path = main_console.instance_variable_get(:@file_path)
  end

  def update_current_account(current_account)
    @current_account = current_account
  end

  def create_card
    accounts_to_store = []
    card_type = check_card

    type = "#{card_type.capitalize}Card"
    card = BasicCard.const_get(type.to_s).new

    current_account.add_card(card)
    accounts_to_store.push current_account
    save_data(@file_path, accounts_to_store)
  end

  def show_cards
    return output_message('error.no_active_cards') unless current_account.cards.any?

    show_cards_list(current_account.cards)
  end

  def destroy_card
    output_message('common.if_you_want_to_delete')
    current_card = find_card(current_account)
    return unless current_card

    return unless confirmed?(user_input('cards.confirm_deletion', number: current_card.number))

    current_account.delete_card(current_card)

    save_card_data(current_account)
  end
end
