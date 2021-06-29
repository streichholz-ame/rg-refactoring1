module ConsoleHelper
  def show_cards_list(cards)
    cards.each do |card|
      output_message('cards.card', number: card.number, type: card.type)
    end
  end

  def show_list_with_index(cards)
    cards.each_with_index do |card, index|
      output_message('cards.card_with_index', number: card.number, type: card.type, index: index + 1)
    end
    output_message(:exit)
  end

  def find_card_position(cards)
    loop do
      show_list_with_index(cards)
      card = gets.chomp
      break(Constants::EXIT_COMMAND) if exit?(card)

      card_position = card.to_i
      break(card_position) if valid_number?(card_position, 1, cards.size)

      output_message('error.wrong_number')
    end
  end

  def user_input(message, parameters = {})
    output_message(message, parameters)
    gets.chomp
  end

  def output_message(message, parameters = {})
    puts I18n.t(message, **parameters)
  end

  def find_card(current_account)
    return output_message('error.no_active_cards') if current_account.cards.empty?

    card_position = find_card_position(current_account.cards)
    return if exit?(card_position)

    current_account.cards[card_position - 1]
  end

  def save_card_data(current_account)
    account_data = [current_account]
    save_data(@file_path, account_data)
  end

  def authenticated?(records)
    @login == records[:login] && @password == records[:password]
  end

  def exit?(command)
    command == Constants::EXIT_COMMAND
  end

  def show_errors(errors)
    errors.each { |error| puts error }
  end

  def find_card_number
    card_number = user_input('common.choose_card_sending')
    validate_card_number(card_number)

    cards_all = accounts.map(&:cards).flatten
    return output_message('error.no_card_number', number: card_number) unless cards_all.any? do |card|
      card.number == card_number
    end

    cards_all.find { |card| card.number == card_number }
  end

  def check_card
    loop do
      card_type = user_input('cards.create_card')
      break card_type if value_exist?(card_type, Constants::CARD_TYPES)

      output_message('error.wrong_card_type')
    end
  end

  def confirmed?(answer)
    answer == Constants::AGREE_COMMAND
  end

  def accounts
    load_data(@file_path)
  end

  def validate_card_number(card_number)
    output_message('error.wrong_card_number') unless card_number.size == Constants::CARD_NUMBER_LENGTH
  end

  def save_cards_data(accounts_to_store)
    save_data(@file_path, accounts_to_store)
  end
end
