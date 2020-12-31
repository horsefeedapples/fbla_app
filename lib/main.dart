import 'package:fbla_app/blocs/auth_bloc.dart';
import 'package:fbla_app/screens/chat/chat_detail_screen.dart';
import 'package:fbla_app/screens/profile/profile_detail_screen.dart';
import 'package:fbla_app/screens/profile/profile_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/other/report_bug_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FBLA App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return BottomNavBar();
            }
            return AuthScreen();
          },
        ),
        initialRoute: '/',
        routes: {
          ProfileEdit.routeName: (ctx) => ProfileEdit(),
          ReportBug.routeName: (ctx) => ReportBug(),
          ProfileDetail.routeName: (ctx) => ProfileDetail(),
          ChatDetail.routeName: (ctx) => ChatDetail(),
        },
      ),
    );
  }
}
