import 'dart:io';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybite_app/helpers/database-helper.dart';
import 'package:foodybite_app/models/User.dart';
import 'package:foodybite_app/pallete.dart';
import 'package:foodybite_app/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';

class CreateNewAccount extends StatefulWidget {
  CreateNewAccount();

  @override
  _CreateNewAccount createState() => _CreateNewAccount();
}

class _CreateNewAccount extends State<CreateNewAccount> {
  final format = DateFormat("dd-MM-yyyy");
  String imagePath;
  String passportPath;
  bool adult = false;
  TextEditingController imeiController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imagePath = pickedFile.path;
    });
    print(pickedFile.path);
  }

  bool isAdult(DateTime birthDate) {
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }

  Future getPassport() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      passportPath = pickedFile.path;
    });
    print(pickedFile.path);
  }

  @override
  void initState() {
    initTextFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/register_bg.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                InkWell(
                  child: Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: imagePath != null
                                ? CircleAvatar(
                                    radius: size.width * 0.14,
                                    backgroundColor:
                                        Colors.grey[400].withOpacity(
                                      0.4,
                                    ),
                                    child: Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: size.width * 0.14,
                                    backgroundColor:
                                        Colors.grey[400].withOpacity(
                                      0.4,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.user,
                                      color: kWhite,
                                      size: size.width * 0.1,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: kWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () => getImage(),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      hint: 'IMEI',
                      controller: imeiController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "The imei field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextInputField(
                      hint: 'First name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: firstNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "The first name field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextInputField(
                      hint: 'Last name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      controller: lastNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "The last name field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextInputField(
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      controller: emailController,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.09,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DateTimeField(
                            format: format,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 19,
                                color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "D.O.B",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                              errorStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  height: 0.3),
                              border: InputBorder.none,
                              fillColor: Colors.transparent,
                              contentPadding:
                                  EdgeInsets.only(top: 12, left: 15),
                            ),
                            validator: (date) =>
                                date == null ? 'Invalid date' : null,
                            onChanged: (value) {
                              setState(() {
                                adult = isAdult(value);
                              });
                            },
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime.now());
                            },
                            controller: dobController,
                          ),
                        )),
                    adult
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: InkWell(
                              child: Container(
                                height: size.height * 0.09,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: passportPath != null
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Image.file(
                                            File(passportPath),
                                            fit: BoxFit.cover,
                                            height: 40,
                                            width: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "${passportPath.substring(0, 10)}...",
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.white,
                                                height: 1.5),
                                          )
                                        ],
                                      )
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 12),
                                        child: Text(
                                          "Passport",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              height: 1.5),
                                        ),
                                      ),
                              ),
                              onTap: () => getPassport(),
                            ))
                        : Container(),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Save',
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          if (imagePath == null) {
                            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                content: new Text("Please add user image")));
                          } else if (adult && passportPath == null){
                            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                content: new Text("Please add your passport")));
                          } else
                            saveUser();
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          )),
        )
      ],
    );
  }

  Future saveUser() async {
    Position position = await Geolocator.getCurrentPosition();
    var db = new DatabaseHelper();
    var user = new User(
        imeiController.text,
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        dobController.text,
        passportPath,
        imagePath,
        Platform.operatingSystem,
        position.latitude.toString(),
        position.longitude.toString());
    await db.saveUser(user);
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("User added successfully.")));
    db.getUser();
  }

  initTextFields() async {
    imeiController.text = await ImeiPlugin.getImei();
  }
}
