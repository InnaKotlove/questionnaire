import 'package:flutter/material.dart';

enum GenderList { male, female }

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender = GenderList.female;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Text(
                  'a. Кличка питомца:',
                  style: TextStyle(fontSize: 10.0),
                ),
                new TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите кличку';
                }),
                new Text(
                  'b. Имя и контакты владельца:',
                  style: TextStyle(fontSize: 10.0),
                ),
                new TextFormField(validator: (value) {
                  if (value!.isEmpty)
                    return 'Пожалуйста введите свое имя и контактные данные';
                }),
                new SizedBox(height: 10.0),
                new Text(
                  'c. Порода питомца:',
                  style: TextStyle(fontSize: 10.0),
                ),
                new TextFormField(validator: (value) {
                  if (value!.isEmpty) return 'Пожалуйста введите породу';
                }),
                new SizedBox(height: 10.0),
                new Text(
                  'e. Самец или самка?:',
                  style: TextStyle(fontSize: 10.0),
                ),
                new RadioListTile(
                  title: const Text('Самец'),
                  value: GenderList.male,
                  groupValue: _gender,
                  onChanged: (GenderList? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                new RadioListTile(
                  title: const Text('Самка'),
                  value: GenderList.female,
                  groupValue: _gender,
                  onChanged: (GenderList? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                new SizedBox(height: 10.0),

                new CheckboxListTile(
                    value: _agreement,
                    title: new Text('f. Сохранить' +
                        (_gender == null
                            ? '()'
                            : _gender == GenderList.male
                                ? ''
                                : '') +
                        ''),
                    onChanged: (bool? value) =>
                        setState(() => _agreement = value!)),
                new SizedBox(height: 10.0),
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Color color = Colors.red;
                      String text;

                      if (_gender == null)
                        text = 'Нажмите сохранить для ввода данных';
                      else if (_agreement == false)
                        text = 'Необходимо сохранить форму';
                      else {
                        text = 'Форма успешно заполнена';
                        color = Colors.green;
                      }

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(text),
                        backgroundColor: color,
                      ));
                    }
                  },
                  child: Text('Проверить'),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            )));
  }
}

void main() => runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
        appBar: new AppBar(title: new Text('Форма опросник')),
        body: new MyForm())));
