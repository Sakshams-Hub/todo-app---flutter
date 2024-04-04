import 'package:flutter/material.dart';

import 'database_helper.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // All datayghhhgh
  List<Map<String, dynamic>> myData = [];
  final formKey = GlobalKey<FormState>();

  bool _isLoading = true;
  String dropdownValue = 'Male';
  List<String> gender = ['Male', 'Female', 'Other'];
  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      myData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _refreshData(); // Loading the data when the app starts
  }

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void showMyForm(int? id) async {
    // id == null -> create new item
    // id != null -> update an existing item
    if (id != null) {
      final existingData = myData.firstWhere((element) => element['id'] == id);
      _fnameController.text = existingData['fname'];
      _lnameController.text = existingData['lname'];
      _ageController.text = existingData['age'].toString();
      dropdownValue = existingData['gender'];
    } else {
      _fnameController.text = "";
      _lnameController.text = "";
      _ageController.text = "";
      dropdownValue = 'Male';
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: _fnameController,
                        validator: formValidator,
                        decoration:
                            const InputDecoration(labelText: "First Name"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: formValidator,
                        controller: _lnameController,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: formValidator1,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Field is Required";
                        //   } else if (value.contains('.')) {
                        //     return 'Decimal not allowed';
                        //   }
                        // },
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Age'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      DropdownButton<String>(
                        value: dropdownValue,
                        items: gender.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        }).toList(),
                        hint: Text("Choose gender"),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue.toString();
                          });
                        },
                      ),

                      // TextFormField(
                      //   // validator: formValidator,
                      //   controller: _genderController,
                      //   decoration: const InputDecoration(labelText: 'Gender'),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Exit")),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (id == null) {
                                  await addItem();
                                }

                                if (id != null) {
                                  await updateItem(id);
                                }

                                // Clear the text fields
                                setState(() {
                                  _fnameController.text = '';
                                  _lnameController.text = '';
                                  _ageController.text = '';
                                  dropdownValue = '';
                                });

                                // Close the bottom sheet
                                Navigator.pop(context);
                              }
                              // Save new data
                            },
                            child: Text(id == null ? 'Create New' : 'Update'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  String? formValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field is Required';
    } else if (value.characters.length <= 3) {
      return 'Letters should be more than 3';
    } else if (value.contains('.')) {
      return 'Decimal not allowed';
    }

    return null;
  }

  String? formValidator1(String? value) {
    if (value!.isEmpty) {
      return 'Field is Required';
    } else if (value.contains('.')) {
      return 'Decimal not allowed';
    }

    return null;
  }

// Insert a new data to the database

  Future<void> addItem() async {
    DatabaseHelper.createItems(_fnameController.text, _lnameController.text,
            int.parse(_ageController.text), dropdownValue)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.toString()),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      _refreshData();
    });
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(id, _fnameController.text,
        _lnameController.text, int.parse(_ageController.text), dropdownValue);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Updated"),
      backgroundColor: Theme.of(context).primaryColor,
    ));
    _refreshData();
  }

  // Delete an item
  void deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqllite CRUD'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : myData.isEmpty
              ? const Center(child: Text("No Data Available!!!"))
              : ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) => Card(
                    color: index % 2 == 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorLight,
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                        title: Text(myData[index]['fname'].toString()),
                        subtitle: Text(myData[index]['lname'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    showMyForm(myData[index]['id']),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    deleteItem(myData[index]['id']),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showMyForm(null),
      ),
    );
  }
}


































































































// import 'package:flutter/material.dart';

// class MyForm extends StatefulWidget {
//   const MyForm({super.key});

//   @override
//   State<MyForm> createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
 
//   final _Key = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Form'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _Key,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                         alignment: Alignment.topCenter,
//                         child: const Text(
//                           "Personal Details",
//                           style: TextStyle(fontSize: 50),
//                         )),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           label: const Text("First Name")),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               width: 3, color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               width: 3, color: Theme.of(context).primaryColor),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         label: const Text("Last Name"),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),

//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           label: Text("Age")),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 3, color: Theme.of(context).primaryColor),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           label: const Text("Gender")),
//                     ),

//                     // DropdownButton(
//                     //     value: dropdownValue,
//                     //     items: items.map<DropdownMenuItem<String>>(
//                     //       (String value) {
//                     //         return DropdownMenuItem<String>(
//                     //             value: value, child: Text(value));
//                     //       },
//                     //     ).toList(),
//                     //     onChanged: null),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context, rootNavigator: true)
//                             .pushNamed('/user');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(160, 50),
//                         backgroundColor: Theme.of(context).primaryColor,
//                         shape: const StadiumBorder(),
//                       ),
//                       child: const Text(
//                         "Submit",
//                         style: TextStyle(fontSize: 25),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//         ),
//       ),
//     );
//   }
// }
