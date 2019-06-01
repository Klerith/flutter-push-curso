import 'package:flutter/material.dart';
import 'package:push_local/src/providers/push_notifications_provider.dart';
 
import 'package:push_local/src/pages/home_page.dart';
import 'package:push_local/src/pages/mensaje_page.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();

    pushProvider.mensajes.listen( (data) {

      // Navigator.pushNamed(context, 'mensaje');
      print('Argumento del Push');
      print(data);

      navigatorKey.currentState.pushNamed('mensaje', arguments: data );

    });

  }


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Local',
      initialRoute: 'home',
      routes: {
        'home'    : (BuildContext context) => HomePage(),
        'mensaje' : (BuildContext context) => MensajePage(),
      },
    );
  }
}