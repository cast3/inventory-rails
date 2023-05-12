import {Controller} from '@hotwired/stimulus'

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
        const clienteCantidad = document.getElementById('cliente-wrapper2')
        const proveedor = document.getElementById('proveedor-wrapper')
        const proveedorCantidad = document.getElementById('proveedor-wrapper2')

        if ((movimiento.style.display = tipoSelect == 0)) {
            proveedor.style.display = 'block'
            proveedorCantidad.style.display = 'block'
            cliente.style.display = 'none'
            clienteCantidad.style.display = 'none'
        } else {
            cliente.style.display = 'block'
            clienteCantidad.style.display = 'block'
            proveedor.style.display = 'none'
            proveedorCantidad.style.display = 'none'
        }
    }
}
