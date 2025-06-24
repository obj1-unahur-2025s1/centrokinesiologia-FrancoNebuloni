object centroKinesiologia {
  const aparatos = []
  const pacientes = []

  method coloresAparatos() = aparatos.map({a => a.color()}.distinct()) 
  method pacientesInfantiles() = pacientes.filter({a => a.edad() < 8})
  method cantidadInutiles() = pacientes.count({a => not a.puedeRealizarRutina()})
}

class Pacientes {
  var property edad
  var nivMuscular
  var nivDolor
  const aparatosAsignados = []

  method nivDolor() = nivDolor
  method aparatosAsignados() = aparatosAsignados
  method nivMuscular() = nivMuscular
  method puedeUsar(unAparato) = unAparato.puedeUsarse(self)
  method usar(unAparato) = if(self.puedeUsar(unAparato)) {
    unAparato.usar(self)
  }
  method setNivDolor(nuevoNivel) {
    nivDolor = nuevoNivel
  } 
  method setNivMuscular(nuevoNivel) {
    nivMuscular = nuevoNivel
  }
  method agregarAparatoAsignado(unAparato) {
    aparatosAsignados.add(unAparato)
  }
  method puedeRealizarRutina() = self.aparatosAsignados().all({a => self.puedeUsar(a)})
  method realizarRutina() {
    self.aparatosAsignados().forEach({a => self.usar(a)})
  } 
}

class Resistente inherits Pacientes{
  override method realizarRutina() {
    super() + (1 * aparatosAsignados.size())
  }
}

class Caprichoso inherits Pacientes {
  override method puedeRealizarRutina() = super() && self.aparatosAsignados().any({a => a.color() == "Rojo"})
}

class RapidaRecuperacion inherits Pacientes {
  var property dolorPedido = 3

  override method realizarRutina() {
    super()
    self.setNivDolor(self.nivDolor() - dolorPedido)
  }
}

class Aparatos {
  var property color = "Blanca"
  method usar(unPaciente)  
  method puedeUsarse(unPaciente) 
  method necesitaMantenimiento() 
  method hacerMantenimiento()  
}

class Magneto inherits Aparatos{
  var imantacion = 800
  override method usar(unPaciente) {
    unPaciente.setNivDolor(unPaciente.nivDolor() - (unPaciente.nivDolor() * 0.1))
    imantacion -= 1
  } 
  override method puedeUsarse(unPaciente) = true
  override method necesitaMantenimiento() = imantacion < 100
  override method hacerMantenimiento() {
    imantacion += 500
  }
}

object magneto inherits Magneto {
  
}

class Bicicleta inherits Aparatos {
  var cantDesajustanTornillos = 0
  var cantPierdeAceite = 0
  override method usar(unPaciente) { 
    unPaciente.setNivDolor(unPaciente.nivDolor() - 4) 
    unPaciente.setNivMuscular(unPaciente.nivMuscular() + 3)
  }
  override method puedeUsarse(unPaciente) = unPaciente.edad() > 8
  method seDesajustanLosTornillos(unPaciente) {
    if(unPaciente.nivDolor() > 30) {
      cantDesajustanTornillos += 1
    }
  }
  method sePierdeAceite(unPaciente) {
    if(unPaciente.edad().between(30, 50)) {
      cantPierdeAceite += 1
    }
  }
  override method necesitaMantenimiento() = cantDesajustanTornillos >= 10 or cantPierdeAceite >= 5
  override method hacerMantenimiento() {
    cantDesajustanTornillos = 0
    cantPierdeAceite = 0
  }
}

object bicicleta inherits Bicicleta {
  
}

class Minitramp inherits Aparatos {
  override method usar(unPaciente) {
    return unPaciente.setNivMuscular(unPaciente.nivMuscular() + (unPaciente.edad() * 0.1))
  }
  override method puedeUsarse(unPaciente) = unPaciente.nivDolor() < 20
  override method necesitaMantenimiento() = false
  override method hacerMantenimiento() {}
}

object minitramp inherits Minitramp {
  
}