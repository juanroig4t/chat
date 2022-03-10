class Mensaje {
    String createdAt;
    String de;
    String mensaje;
    String para;
    String updatedAt;

    Mensaje({required this.createdAt, required this.de, required this.mensaje, required this.para, required this.updatedAt});

    factory Mensaje.fromJson(Map<String, dynamic> json) {
        return Mensaje(
            createdAt: json['createdAt'], 
            de: json['de'], 
            mensaje: json['mensaje'], 
            para: json['para'], 
            updatedAt: json['updatedAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createdAt'] = this.createdAt;
        data['de'] = this.de;
        data['mensaje'] = this.mensaje;
        data['para'] = this.para;
        data['updatedAt'] = this.updatedAt;
        return data;
    }
}