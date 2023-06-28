import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String selectedGender = '';

  void _onRadioButtonChanged(String value) {
    print(value);
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: '',
                onSaved: (value) => name = value!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ชาย'),
                  Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) => _onRadioButtonChanged(value!)),
                  Text('หญิง'),
                  Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) => _onRadioButtonChanged(value!)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    print(name);
                    print('save');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page2(
                          title: name,
                          gender: selectedGender,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
    required this.title,
    required this.gender,
  });

  final String title;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(gender),
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('กลับไปหน้าหลัก')),
          ],
        ),
      ),
    );
  }
}
