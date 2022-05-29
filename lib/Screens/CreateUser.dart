import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:diplom_work/Data/User.dart';

import '../Data/File_List.dart';

const String inputDataUser = 'ghgh';


class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  File? _image;
  final _picked = ImagePicker();
  final professions = ['', 'Охранник', 'Менеджер', 'Уборщик', 'Директор'];
  final department = [
    '',
    'отдел Безопасности',
    'отдел Маркетинга',
    'отдел Клининга',
    'Дирекция'
  ];
  String time = '?';
  DateTime? _MyDateTime;
  String? valueProf;
  String? valueDep;
  Object? _radiovalue = 1;
  FilePickerResult? result;
  PlatformFile? file;

  _imgFromCamera() async {
    PickedFile? image =
    await _picked.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    PickedFile? image =
    await _picked.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  DropdownMenuItem<String> buildMenuItemP(String professions) =>
      DropdownMenuItem(
        value: professions,
        child: Text(professions),
      );

  DropdownMenuItem<String> buildMenuItemD(String department) =>
      DropdownMenuItem(
        value: department,
        child: Text(department),
      );

  // void _loadFormData(UserP user){
  //
  //   if(user != null){
  //
  //     _formData['id'] = user.id ;
  //     _formData['avatarUrl'] = user.avatarUrl ;
  //     _formData['name'] = user.name;
  //     _formData['jobTitle'] = user.jobTitle;
  //     _formData['email'] = user.email;
  //     _formData['phone'] = user.phone;
  //     _formData['addressR'] = user.addressR;
  //     _formData['addressP'] = user.addressP;
  //     _formData['idSeries'] = user.idSeries;
  //     _formData['idNum'] = user.idNum;
  //     _formData['idcreateData'] = user.idcreateData;
  //     _formData['idwhoGive'] = user.idwhoGive;
  //     _formData['tariff'] = user.tariff;
  //     _formData['money'] = user.money;
  //
  //   }
  // }

  void pickFiless() async{
    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result == null) return;
    file = result!.files.first;
    setState(() {});

    loadSelectedFile(result!.files);
  }

  void loadSelectedFile(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
        FileList(files: files, onOpenedFile: viewFile)));
  }

  void viewFile(PlatformFile file){
    OpenFile.open(file.path);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление работника'),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text('Добавить'),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              _buildImagePickerSection(),
              _buildSpecSection(),
            ],
          )
        ],
      ),
    );
  }

  Column _buildImagePickerSection() {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton(
          child: Text('Добавить фото'),
          onPressed: () {
            _showPicker(context);
          },
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Container _buildSpecSection() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 5),
          Text('ФИО:'),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Введите ФИО',
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Text('Должность:'),
                    SizedBox(height: 5),
                    DropdownButton<String>(
                      value: valueProf,
                      items: professions.map(buildMenuItemP).toList(),
                      onChanged: (value) =>
                          setState(() => this.valueProf = value),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Text('Департамент:'),
                    SizedBox(height: 5),
                    DropdownButton<String>(
                      value: valueDep,
                      items: department.map(buildMenuItemD).toList(),
                      onChanged: (value) =>
                          setState(() => this.valueDep = value),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('e-mail:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Введите e-mail',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Телефон:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Введите телефон',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Адрес регистрации:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Введите адрес регистрации',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Адрес проживания:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Введите адрес проживания',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Паспорт:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(children: [
                  Text('Серия:'),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Введите серию паспорта',
                      ),
                    ),
                  ),
                  Text('Номер:'),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Введите номер паспорта',
                      ),
                    ),
                  ),
                  Text('Дата выдачи'),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Введите дату выдачи',
                      ),
                    ),
                  ),
                  Text('Кем выдан:'),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Введите название учереждения',
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Оплата:'),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _radiovalue,
                          onChanged: (value) {
                            setState(() {
                              _radiovalue = value;
                            });
                          },
                        ),
                        SizedBox(width: 10,),
                        Text('Тариф'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _radiovalue,
                          onChanged: (value) {
                            setState(() {
                              _radiovalue = value;
                            });
                          },
                        ),
                        SizedBox(width: 10,),
                        Text('Оклад'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('Сумма:'),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Введите сумму',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Text('Файлы:'),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: (){
                      pickFiless();
                    },child: Text('Добавть файл'),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: (){
                      viewFile(file!);
                    },child: Text('Просмотреть файл'),
                  ),
                  SizedBox(width: 15)
                ],
              ),
              if(file != null) _fileDetails(file!)
            ],
          )
        ],
      ),
    );
  }
  Widget _fileDetails(PlatformFile file){
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }
}
