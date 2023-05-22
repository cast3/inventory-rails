class User < ApplicationRecord
  include Signupable
  include Onboardable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[empleado admin]
  after_initialize :set_default_role, if: :new_record?
  validates :email, uniqueness: true, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'no es un correo electrónico válido' }
  validates :password,
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
                      message: 'Debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un caracter especial' }

  def set_default_role
    self.role ||= :empleado
  end

  private

  def passwords_match
    return unless password != password_confirmation

    errors.add(:password_confirmation, 'Las contraseñas no coinciden')
  end
end
