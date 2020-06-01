import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '2d scrollable map'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _mapWidth = 1000.0;
  final double _mapHeight = 1000.0;
  final double _cameraHeight = 300.0;
  final double _cameraWidth = 300.0;
  double _leftPos = 0.0; //the offset of the widget position relative to the camera
  double _topPos = 0.0;  //the offset of the widget position relative to the camera

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var camera = GestureDetector(
      onPanUpdate: (details){
        var topPos = _topPos + details.delta.dy;
        var leftPos = _leftPos + details.delta.dx;
        topPos = _boundaryRule(topPos,_mapHeight, _cameraHeight);
        leftPos = _boundaryRule(leftPos,_mapWidth, _cameraWidth);
        //set the state
        setState(() {
          _topPos = topPos;
          _leftPos = leftPos;
        });
      },
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.8),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left:_leftPos+0,
              top:_topPos+0,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.black,
              ),
            ),
            Positioned(
              left:_leftPos+900,
              top:_topPos+900,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: camera,
      ),
    );
  }
  double _boundaryRule(position, mapLength, cameraLength){
    // this function will prevent the widget from moving if it reached the boundary
    if (position < (cameraLength-mapLength)){
      position = cameraLength- mapLength;
    }
    if (position> 0){
      position = 0.0;
    }

    return position;
  }
}
