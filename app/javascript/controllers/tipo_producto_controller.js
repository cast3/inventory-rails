import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tipo-producto"
export default class extends Controller {
  connect() {
    this.toggleFechaDeCaducidad();
  }

  click(event) {
    this.toggleFechaDeCaducidad(event.target.value);
  }

  toggleFechaDeCaducidad(tipoSelect = this.element.value) {
    const fechaDeCaducidad = document.getElementById("fecha_de_caducidad");
    fechaDeCaducidad.style.display = tipoSelect === "Perecedero" ? "block" : "none";
  }
}
