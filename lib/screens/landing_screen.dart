import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:test_farm/components/data_container.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phNo = TextEditingController();
  Future<void> addUser(
      String firstName, String lastName, String phNo, String email) {
    // Call the user's CollectionReference to add a new user
    return users.doc(phNo).set({
      'First Name': firstName, // John Doe
      'Last Name': lastName, // Stokes and Sons
      'Email Id': email,
      'Phone No': phNo // 42
    });
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    SideMenuController page = SideMenuController();
    final PageController controller = PageController();
    List<SideMenuItem> items = [
      SideMenuItem(
        priority: 1,
        title: 'Menu 1',
        onTap: (int i, page) {
          page.changePage(0);
          controller.jumpToPage(0);
        },
      ),
      SideMenuItem(
        priority: 2,
        title: 'Menu 2',
        onTap: (int i, page) {
          controller.jumpToPage(1);
        },
      ),
      SideMenuItem(
        priority: 3,
        title: 'Menu 3',
        tooltipContent: '3',
        onTap: (int i, SideMenuController j) {
          controller.jumpToPage(2);
        },
      ),
      SideMenuItem(
        priority: 4,
        title: 'Menu 4',
        onTap: (int i, SideMenuController j) {
          controller.jumpToPage(3);
        },
      ),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        // backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Image.asset('assets/images/farmonaut.jpg'),
        ),
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: SideMenu(
                // Page controller to manage a PageView
                controller: page,
                style: SideMenuStyle(
                    displayMode: SideMenuDisplayMode.open,
                    openSideMenuWidth: 200,
                    itemOuterPadding: const EdgeInsets.all(4.0),
                    // compactSideMenuWidth: 40,
                    hoverColor: Colors.teal[900],
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.black),
                    unselectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    // iconSize: 20,
                    itemBorderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    showTooltip: true,
                    toggleColor: Colors.black54),
                items: items,
              ),
            ),
            Flexible(
              flex: 4,
              child: PageView(controller: controller, children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      textField('First Name', firstName),
                                      textField('Last Name', lastName),
                                      textField('Email', email),
                                      textField('Phone Number', phNo),
                                    ]),
                                GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 100.0,
                                      height: 48.0,
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onTap: () {
                                    addUser(firstName.text, lastName.text,
                                        phNo.text, email.text);
                                    firstName.text = '';
                                    lastName.text = '';
                                    phNo.text = '';
                                    email.text = '';
                                  },
                                )
                              ]),
                          StreamBuilder<QuerySnapshot>(
                            stream: _usersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }

                              return Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    for (var i = 0;
                                        i < snapshot.data!.size;
                                        i++)
                                      DataContainer(
                                        fname: snapshot.data!.docs[i]
                                            ['First Name'],
                                        lname: snapshot.data!.docs[i]
                                            ['Last Name'],
                                        phone: snapshot.data!.docs[i]
                                            ['Phone No'],
                                        email: snapshot.data!.docs[i]
                                            ['Email Id'],
                                      )
                                  ]);
                            },
                          )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Farmonaut '
                    'Menu 2',
                    style:
                        TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Farmonaut'
                    'Menu 3',
                    style:
                        TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Farmonaut'
                    'Menu 4',
                    style:
                        TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ],
        ),
      );
    });
  }
}

Widget textField(String title, TextEditingController control) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: 200,
      child: TextFormField(
          controller: control,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: title,
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          )),
    ),
  );
}
