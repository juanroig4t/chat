class Usuario {
    String? email;
    String? nombre;
    bool? online;
    String? uid;

    Usuario({this.email, this.nombre, this.online, this.uid});

    factory Usuario.fromJson(Map<String, dynamic> json) {
        return Usuario(
            email: json['email'], 
            nombre: json['nombre'], 
            online: json['online'], 
            uid: json['uid'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['nombre'] = this.nombre;
        data['online'] = this.online;
        data['uid'] = this.uid;
        return data;
    }
}