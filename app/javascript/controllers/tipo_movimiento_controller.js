import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="tipo-movimiento"
export default class extends Controller {
    connect() {
        this.toggleClienteorProveedor()
    }

    click(event) {
        this.toggleClienteorProveedor(event.target.value)
    }

    toggleClienteorProveedor(tipoSelect = this.element.value) {
        const movimiento = document.getElementById('tipo_movimiento')
        const cliente = document.getElementById('cliente-wrapper')
        const proveedor = document.getElementById('proveedor-wrapper')

        if ((movimiento.style.display = tipoSelect == 0)) {
            proveedor.style.display = 'block'
            cliente.style.display = 'none'
        } else {
            cliente.style.display = 'block'
            proveedor.style.display = 'none'
        }
    }
}
