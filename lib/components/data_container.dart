import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_farm/components/text_field_pop.dart';

class DataContainer extends StatefulWidget {
  const DataContainer(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.phone,
      required this.email})
      : super(key: key);
  final String fname, lname, phone, email;

  @override
  State<DataContainer> createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  TextEditingController eF = TextEditingController();
  TextEditingController eL = TextEditingController();
  TextEditingController eE = TextEditingController();
  TextEditingController eP = TextEditingController();

  Future<void> addUser(
      String firstName, String lastName, String phNo, String email) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users.doc(phNo).set({
      'First Name': firstName, // John Doe
      'Last Name': lastName, // Stokes and Sons
      'Email Id': email,
      'Phone No': phNo // 42
    });
  }

  @override
  void initState() {
    super.initState();
    eF.text = widget.fname;
    eL.text = widget.lname;
    eE.text = widget.email;
    eP.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.6),
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.2),
            ], stops: const [
              0.0,
              0.5,
              1.0
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            border: Border.all(
              color: Colors.white10,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(40.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30)),
                              ),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Edit Info'),
                                          Wrap(
                                              direction: Axis.horizontal,
                                              alignment: WrapAlignment.center,
                                              runAlignment:
                                                  WrapAlignment.center,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                TextFieldPop(
                                                    title: 'First Name',
                                                    controller: eF,
                                                    value: widget.fname),
                                                TextFieldPop(
                                                    title: 'Last Name',
                                                    controller: eL,
                                                    value: widget.lname),
                                                TextFieldPop(
                                                    title: 'Email',
                                                    controller: eE,
                                                    value: widget.email),
                                                TextFieldPop(
                                                    title: 'Phone Number',
                                                    controller: eP,
                                                    value: widget.phone),
                                              ]),
                                          TextButton(
                                            child: const Text('Edit'),
                                            onPressed: () async {
                                              CollectionReference users =
                                                  FirebaseFirestore.instance
                                                      .collection('Users');
                                              await users
                                                  .doc(widget.phone)
                                                  .delete()
                                                  .then((value) => null)
                                                  .catchError((error) => null);
                                              addUser(eF.text, eL.text, eE.text,
                                                  eP.text);
                                              eF.text = '';
                                              eL.text = '';
                                              eE.text = '';
                                              eP.text = '';
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          // CollectionReference users =
                          // FirebaseFirestore.instance.collection('users');
                          // Future<void> updateUser() {
                          //       return users
                          //           .doc(phNo)
                          //           .update({'company': 'Stokes and Sons'})
                          //           .then((value) => print("User Updated"))
                          //           .catchError((error) =>
                          //               print("Failed to update user: $error"));
                          // }
                        },
                        child: const Icon(Icons.edit)),
                    InkWell(
                        onTap: () async {
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('Users');
                          await users
                              .doc(widget.phone)
                              .delete()
                              .then((value) => null)
                              .catchError((error) => null);
                        },
                        child: const Icon(Icons.delete))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Full Name: ${widget.fname} ${widget.lname}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Email: ${widget.email}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone Number: ${widget.phone}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
