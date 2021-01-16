import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_map_field/form_builder_map_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilderMapField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String fieldName = 'coordinates';

  GlobalKey<FormBuilderState> _formKey = GlobalKey();
  CameraPosition cameraPosition;

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormBuilderMapField Example'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              FormBuilderMapField(
                name: fieldName,
                initialValue: cameraPosition,
                decoration: InputDecoration(labelText: 'Select Location'),
                markerIconColor: Colors.red,
                markerIconSize: 50,
                onChanged: (val) {
                  print('Camera position changed $val');
                },
              ),
              RaisedButton(
                child: Text('get form camera position'),
                onPressed: () {
                  setState(() {
                    cameraPosition = _formKey.currentState.fields[fieldName].value as CameraPosition;
                  });
                },
              ),
              Text('Camera pos $cameraPosition'),
            ],
          ),
        ),
      ),
    );
  }
}
