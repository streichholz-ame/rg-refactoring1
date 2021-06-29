class AccountCommands
  include ConsoleHelper
  include Validation
  include DataLoader

  attr_accessor :main_console, :file_path

  def initialize(console)
    @main_console = console
    @file_path = main_console.instance_variable_get(:@file_path)
  end

  def create_account
    loop do
      account = Account.new(create_account_fields)
      account.errors.push(I18n.t('validation.login.exists')) if value_exist?(account.login, accounts.map(&:login))
      break account if account.valid?

      show_errors(account.errors)
    end
  end

  def load_account
    loop do
      return create_the_first_account if accounts.empty?

      credentials_current = credentials_fields
      if accounts.any? { |account| account.authenticated?(credentials_current) }
        return @current_account = accounts.find { |account| credentials_current[:login] == account.login }
      end

      output_message('error.no_account')
    end
  end

  def create_the_first_account
    user_input('common.create_first_account') == Constants::AGREE_COMMAND ? main_console.create : main_console.console
  end

  def destroy_account(current_account)
    return unless confirmed?(user_input('common.destroy_account'))

    accounts_left = accounts.delete_if { |account| account.login == current_account.login }
    save_data(file_path, accounts_left)
  end

  private

  def create_account_fields
    {
      name: user_input('input.name'),
      age: user_input('input.age').to_i,
      login: user_input('input.login'),
      password: user_input('input.password')
    }
  end

  def credentials_fields
    {
      login: user_input('input.login'),
      password: user_input('input.password')
    }
  end
end
