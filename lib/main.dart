import 'package:flutter/material.dart';
import 'file:///C:/Users/loren/AndroidStudioProjects/myPWA/scrappy/lib/services/route_service.dart';
import 'package:myPWA/src/theme/scrappy_theme.dart';
import 'package:scrappy/components/pages/main_loader/components/loading_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: scrappyTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: LoadingPage.routeName,
      routes: {
        LoadingPage.routeName: (context) => RouteController(child: LoadingPage(), routeName: LoadingPage.routeName,),
      },
    );
  }
}
