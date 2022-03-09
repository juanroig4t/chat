import 'Usuario.dart';

class LoginRepsonse {
    bool? ok;
    String? token;
    Usuario? usuario;

    LoginRepsonse({this.ok, this.token, this.usuario});

    factory LoginRepsonse.fromJson(Map<String, dynamic> json) {
        return LoginRepsonse(
            ok: json['ok'], 
            token: json['token'], 
            usuario: json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        data['token'] = this.token;
        if (this.usuario != null) {
            data['usuarioDb'] = this.usuario?.toJson();
        }
        return data;
    }
}