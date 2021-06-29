module AccountValidate
  include Validation

  def validate_name
    @errors.push(I18n.t('validation.name.first_letter')) if value_empty?(@name) || @name[0].upcase != @name[0]
  end

  def validate_login
    @errors.push(I18n.t('validation.login.present')) if value_empty?(@login)
    @errors.push(I18n.t('validation.login.shorter')) if value_long?(@login, Validation::MAX_LOGIN_LENGTH)
    @errors.push(I18n.t('validation.login.longer')) if value_short?(@login, Validation::MIN_LOGIN_LENGTH)
  end

  def validate_password
    @errors.push(I18n.t('validation.password.present')) if value_empty?(@password)
    @errors.push(I18n.t('validation.password.shorter')) if value_long?(@password, Validation::MAX_PASSWORD_LENGTH)
    @errors.push(I18n.t('validation.password.longer')) if value_short?(@password, Validation::MIN_PASSWORD_LENGTH)
  end

  def validate_age
    @errors.push(I18n.t('validation.age.length')) unless valid_number?(@age, Validation::MIN_AGE, Validation::MAX_AGE)
  end
end
