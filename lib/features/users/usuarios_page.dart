
import 'package:chat/datasource/auth_service.dart';
import 'package:chat/datasource/chat_service.dart';
import 'package:chat/datasource/socket_service.dart';
import 'package:chat/datasource/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:users/domain/Usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarioService = UsuarioService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('${usuario.nombre}', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54,),
          onPressed: (){
            AuthService.deleteToken();
            socketService.disconnect();
            Navigator.of(context).pushReplacementNamed('login');
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                    ? Icon(Icons.check_circle, color: Colors.blue.shade400,)
                    : Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ) ,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400,),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _listViewUsuarios(),


      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
          title: Text('${usuario.nombre}'),
          subtitle: Text('${usuario.email}'),
          leading: CircleAvatar(
            child: Text('${usuario.nombre?.substring(0,2)}'),
            backgroundColor: Colors.blue.shade100,
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: (usuario.online != null && usuario.online == true)
                  ? Colors.green.shade300 : Colors.red.shade300,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
      onTap: () {
            final chatService = Provider.of<ChatService>(context, listen: false);
            chatService.usuarioPara = usuario;
            Navigator.pushNamed(context, 'chat');
      },
        );
  }

  _cargarUsuarios() async{
    // await Future.delayed(const Duration(milliseconds: 1200));

    usuarios = await usuarioService.getUsuarios() as List<Usuario>;
    setState(() {});

    _refreshController.refreshCompleted();

  }
}
