import 'package:flutter/material.dart';
import 'package:status_app/repository/api/status_Api.dart';
import 'package:status_app/repository/bloc/status_bloc.dart';
import 'package:status_app/screens/screen_status/screen_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  ApiStatus apiStatus = ApiStatus();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatusBloc>(
          create: (context) => StatusBloc(apiStatus),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'status checking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenStatus(),
        //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
