require 'yaml'
require 'i18n'

require_relative 'config/config'

require_relative 'modules/constants'
require_relative 'modules/validation'
require_relative 'modules/account_validate'
require_relative 'modules/data_loader'
require_relative 'modules/console_helper'

require_relative 'entities/commands/transaction_commands'
require_relative 'entities/commands/card_commands'
require_relative 'entities/commands/account_commands'
require_relative 'entities/money_operations'

require_relative 'entities/cards/basic_card'
require_relative 'entities/cards/capitalist_card'
require_relative 'entities/cards/usual_card'
require_relative 'entities/cards/virtual_card'

require_relative 'entities/account'
require_relative 'entities/console'
