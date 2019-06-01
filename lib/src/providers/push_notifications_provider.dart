import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';
import 'dart:async';

class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;


  initNotifications() {

    _firebaseMessaging.requestNotificationPermissions();


    _firebaseMessaging.getToken().then( (token) {


      print('===== FCM Token =====');
      print( token );

    });


    _firebaseMessaging.configure(

      onMessage: ( info ) {

        print('======= On Message ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['comida'] ?? 'no-data';
        } else {
          argumento = info['comida'] ?? 'no-data-ios';
        }

        _mensajesStreamController.sink.add(argumento);

      },
      onLaunch: ( info ) {

        print('======= On Launch ========');
        print( info );

        

      },

      onResume: ( info ) {

        print('======= On Resume ========');
        print( info );


        String argumento = 'no-data';

        if ( Platform.isAndroid  ) {  
          argumento = info['data']['comida'] ?? 'no-data';
        } else {
          argumento = info['comida'] ?? 'no-data-ios';
        }
        
        _mensajesStreamController.sink.add(argumento);

      }


    );


  }


  dispose() {
    _mensajesStreamController?.close();
  }

}

