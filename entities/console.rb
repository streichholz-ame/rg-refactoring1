class Console
  include ConsoleHelper
  include DataLoader
  include Validation

  attr_accessor :file_path, :current_account, :account_commands, :transaction_commands, :card_commands

  def initialize
    @file_path = Constants::FILE_PATH
    @account_commands = AccountCommands.new(self)
    @transaction_commands = TransactionCommands.new(self)
    @card_commands = CardCommands.new(self)
  end

  def console
    scenario = user_input(:hello)

    case scenario
    when Constants::CREATE_COMMAND then create
    when Constants::LOAD_COMMAND then load
    else exit
    end
  end

  def load
    @current_account = account_commands.load_account
    update_current_account(current_account)
    main_menu
  end

  def create
    @current_account = account_commands.create_account
    update_current_account(current_account)
    new_accounts = accounts << current_account
    save_data(@file_path, new_accounts)
    main_menu
  end

  def main_menu
    loop do
      output_message(:welcome, user_name: current_account.name)
      command = user_input(:main_menu)
      break Constants::EXIT_COMMAND if exit?(command)

      check_command(command)
    end
  end

  def check_command(command)
    case command.upcase
    when *Constants::CARD_COMMANDS then card_command_choose(command)
    when *Constants::MONEY_COMMANDS then money_command_choose(command)
    when Constants::OPERATIONS[:destroy_account] then account_commands.destroy_account(current_account)
    else output_message('error.wrong_command')
    end
  end

  private

  def update_current_account(current_account)
    card_commands.update_current_account(current_account)
    transaction_commands.update_current_account(current_account)
  end

  def card_command_choose(command)
    case command.upcase
    when Constants::OPERATIONS[:show_cards] then card_commands.show_cards
    when Constants::OPERATIONS[:create_card] then card_commands.create_card
    when Constants::OPERATIONS[:destroy_card] then card_commands.destroy_card
    when Constants::EXIT_COMMAND then main_menu
    else output_message('error.wrong_command')
    end
  end

  def money_command_choose(command)
    case command
    when Constants::OPERATIONS[:put_money] then transaction_commands.put_money
    when Constants::OPERATIONS[:withdraw_money] then transaction_commands.withdraw_money
    when Constants::OPERATIONS[:send_money] then transaction_commands.send_money
    when Constants::EXIT_COMMAND then main_menu
    else output_message('error.wrong_command')
    end
  end
end
