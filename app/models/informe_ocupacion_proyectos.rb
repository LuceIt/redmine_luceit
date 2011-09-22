class InformeOcupacionProyectos
  attr_reader :inicio, :fin, :informes_personales

  def initialize(fecha_inicio, fecha_fin)
    @inicio, @fin = fecha_inicio, fecha_fin
    @informes_personales = {}
    generar_informe_de_cada_proyecto
  end
end
