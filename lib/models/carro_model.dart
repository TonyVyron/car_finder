class CarroModel {
  String? uid;
  String? uid_vendedor;
  List? fotos;
  String? nombre_carro;
  String? nombre_marca;
  int? precio;
  String? kilometraje;
  String? tipo_gasolina;
  String? carroceria;
  String? ano_modelo;
  String? color;
  int? tipo_agregado;
  String? numero_puertas;
  String? fecha_compra;
  String? detalles;
  String? detalle_principal;
  String? garantia;
  String? transmicion;
  String? traccion;
  String? estado_porcentaje;
  int? porcentaje_falla;
  int? porcentaje_descuento;
  String? guia_mantenimiento;

  CarroModel(
      {this.uid,
      this.uid_vendedor,
      this.fotos,
      this.nombre_carro,
      this.nombre_marca,
      this.precio,
      this.porcentaje_falla,
      this.kilometraje,
      this.transmicion,
      this.tipo_gasolina,
      this.carroceria,
      this.ano_modelo,
      this.tipo_agregado,
      this.color,
      this.detalle_principal,
      this.numero_puertas,
      this.fecha_compra,
      this.detalles,
      this.garantia,
      this.traccion,
      this.estado_porcentaje,
      this.porcentaje_descuento,
      this.guia_mantenimiento});

  factory CarroModel.fromMap(map) {
    return CarroModel(
        uid: map['uid'],
        transmicion: map['transmicion'],
        uid_vendedor: map['uid_vendedor'],
        fotos: map['fotos'],
        nombre_carro: map['nombre_carro'],
        nombre_marca: map['nombre_marca'],
        precio: map['precio'],
        detalle_principal: map['detalle_principal'],
        kilometraje: map['kilometraje'],
        porcentaje_falla: map['porcentaje_falla'],
        tipo_gasolina: map['tipo_gasolina'],
        carroceria: map['carroceria'],
        ano_modelo: map['ano_modelo'],
        tipo_agregado: map['tipo_agregado'],
        color: map['color'],
        numero_puertas: map['numero_puertas'],
        fecha_compra: map['fecha_compra'],
        detalles: map['detalles'],
        garantia: map['garantia'],
        traccion: map['traccion'],
        estado_porcentaje: map['estado_porcentaje'],
        porcentaje_descuento: map['porcentaje_descuento'],
        guia_mantenimiento: map['guia_mantenimiento']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'uid_vendedor': uid_vendedor,
      'fotos': fotos,
      'nombre_carro': nombre_carro,
      'nombre_marca': nombre_marca,
      'precio': precio,
      'transmicion': transmicion,
      'kilometraje': kilometraje,
      'porcentaje_falla': porcentaje_falla,
      'tipo_gasolina': tipo_gasolina,
      'carroceria': carroceria,
      'ano_modelo': ano_modelo,
      'detalle_principal': detalle_principal,
      'color': color,
      'tipo_agregado': tipo_agregado,
      'numero_puertas': numero_puertas,
      'fecha_compra': fecha_compra,
      'detalles': detalles,
      'garantia': garantia,
      'traccion': traccion,
      'estado_porcentaje': estado_porcentaje,
      'porcentaje_descuento': porcentaje_descuento,
      'guia_mantenimiento': guia_mantenimiento,
    };
  }
}
