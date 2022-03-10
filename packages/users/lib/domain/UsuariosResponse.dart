import 'Usuario.dart';

class UsuariosResponse {
    bool ok;
    List<Usuario>? usuarios;

    UsuariosResponse({ required this.ok, this.usuarios});

    factory UsuariosResponse.fromJson(Map<String, dynamic> json) {
        return UsuariosResponse(
            ok: json['ok'], 
            usuarios: json['usuarios'] != null ? (json['usuarios'] as List).map((i) => Usuario.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        if (this.usuarios != null) {
            data['usuarios'] = this.usuarios?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}