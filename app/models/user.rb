class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include Signupable
  include Onboardable

  enum role: %i[empleado admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :empleado
  end

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
                                 message: 'Debe tener al menos 8 caracteres, una mayúscula, una minúscula, un
                                 número y un caracter especial' }

  private

  def passwords_match
    return unless password != password_confirmation

    errors.add(:password_confirmation, 'Las contraseñas no coinciden')
  end
end
