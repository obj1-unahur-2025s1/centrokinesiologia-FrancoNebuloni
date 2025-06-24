class Pacientes {
  var property edad
  var nivMuscular
  var nivDolor

  method nivDolor() = nivDolor
  method nivMuscular() = nivMuscular
  method puedeUsar(unAparato) = unAparato.puedeUsarse(self)
  method usar(unAparato) = if(self.puedeUsar(unAparato)) {
    unAparato.usar(self)
  }
}

class Aparatos {
  method usar(unPaciente)  
  method puedeUsarse(unPaciente) 
}

class Magneto inherits Aparatos{
  override method usar(unPaciente) = unPaciente.nivDolor() - (unPaciente.nivDolor() * 0.1)
  override method puedeUsarse(unPaciente) = true
}

object magneto inherits Magneto {
  
}

class Bicicleta inherits Aparatos {
  override method usar(unPaciente) {
    return
    unPaciente.nivDolor() - 4
    unPaciente.nivMuscular() + 3
  }
  override method puedeUsarse(unPaciente) = unPaciente.edad() > 8
}

object bicicleta inherits Bicicleta {
  
}

class Minitramp inherits Aparatos {
  override method usar(unPaciente) {
    return unPaciente.nivMuscular() + (unPaciente.edad() * 0.1)
  }
  override method puedeUsarse(unPaciente) = unPaciente.nivDolor() < 20
}

object minitramp inherits Minitramp {
  
}