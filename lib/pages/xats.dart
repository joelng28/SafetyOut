import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chats extends StatefulWidget {
  Chats({Key key}) : super(key: key);

  @override
  _Chats createState() => _Chats();
}

class _Chats extends State<Chats> {
  @override
  void initState() {
    super.initState();
    IO.Socket socket = IO.io('https://safetyout.herokuapp.com/');
    socket.connect();
    socket.emit('join', {
      'user1_id': '6081a40d875b4b3864bd1f21',
      'user2_id': '609116e842fa750022ab15b7'
    });
    //socket.emit('message', {'chatRoom': })
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
          Text('Xats'),
        ],
      ),
    );
  }
}
