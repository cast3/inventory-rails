require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    subject.validate
  end
  context 'check attr product' do
    it { is_expected.to be_instance_of(Product) }
    it { is_expected.to have_attributes(nombre: nil, referencia: nil, precio: nil, image: nil,fecha_caducidad: nil, category_id: nil, tipo: 'Producto')}
  end
  # attributes are already so we need to do some steps
  context 'validations' do
    context 'Fields required' do
      it '#nombre' do
        expect(subject.errors.messages_for(:nombre).first).to include('no puede estar en blanco')
      end
      it '#referencia' do
        expect(subject.errors.messages_for(:referencia).first).to include('no puede estar en blanco')
      end
      it '#precio' do
        expect(subject.errors.messages_for(:precio).first).to include('no puede estar en blanco')
      end
    end
    context 'Rules validation' do
      let(:product) { build_stubbed(:product) }
      it 'nombre max length ' do
        product.validate
        expect(product.nombre).to_not be_nil
        expect(product.nombre).to have_attributes(size: (be < 50))
        expect(subject.errors.messages_for(:nombre).first).to_not include('max length')
      end
      it '#referencia max' do
        product.validate
        expect(product.referencia).to_not be_nil
        expect(product.referencia).to have_attributes(size: (be < 15))
        expect(subject.errors.messages_for(:referencia).first).to_not include('max length')
      end
    end
  end
end
