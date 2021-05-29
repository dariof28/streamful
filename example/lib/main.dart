import 'package:example/bloc.dart';
import 'package:flutter/material.dart';
import 'package:streamful/streamful.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Streamful Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Streamful Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color? _color = Colors.blue;
  double _strokeWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Streamful',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _buildColorPicker(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _buildStrokeSizer(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _buildActionButtons(),
        ),
        StreamWidget<String?>(
          stream: bloc.data,
          onData: (data) => Text(data!),
          onError: (error) => Text(error.toString()),
          onLoad: StreamedLoading(
            stream: bloc.isLoading,
            color: _color,
            strokeWidth: _strokeWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Select a color'),
          ),
        ),
        Expanded(
          child: DropdownButton<Color>(
            isExpanded: true,
            value: _color,
            items: _colors,
            onChanged: (color) {
              setState(() {
                _color = color;
              });
            },
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<Color>> get _colors {
    Map<String, Color> colors = {
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Orange': Colors.orange,
      'Green': Colors.green,
    };

    List<DropdownMenuItem<Color>> _list = [];

    colors.forEach((key, value) {
      _list.add(
        DropdownMenuItem(child: Text(key), value: value),
      );
    });

    return _list;
  }

  Widget _buildStrokeSizer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Set the stroke width'),
          ),
        ),
        Expanded(
          child: Slider(
            min: 1,
            max: 10,
            value: _strokeWidth,
            onChanged: (value) {
              setState(() {
                _strokeWidth = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        RaisedButton(
          onPressed: () {
            bloc.getData();
          },
          child: Text('Success'),
        ),
        Spacer(),
        RaisedButton(
          onPressed: () {
            bloc.getError();
          },
          child: Text('Error'),
        ),
      ],
    );
  }
}
