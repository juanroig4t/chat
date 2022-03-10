import 'Mensaje.dart';

class MensajesResponse {
    List<Mensaje>? mensajes;
    bool ok;

    MensajesResponse({this.mensajes, required this.ok});

    factory MensajesResponse.fromJson(Map<String, dynamic> json) {
        return MensajesResponse(
            mensajes: json['mensajes'] != null ? (json['mensajes'] as List).map((i) => Mensaje.fromJson(i)).toList() : null, 
            ok: json['ok'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        if (this.mensajes != null) {
            data['mensajes'] = this.mensajes?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}