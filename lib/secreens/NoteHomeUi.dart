import 'package:flutter/material.dart';
import '../services/NoteDbHelper.dart';
import 'descriptionnote.dart';

class NoteHomeUI extends StatefulWidget {
  const NoteHomeUI({super.key});

  @override
  State<NoteHomeUI> createState() => _NoteHomeUIState();
}

class _NoteHomeUIState extends State<NoteHomeUI> {

  ///////////////////////////insert database/////////////////////////////

  insertdatabase(tittle, description) {
    NoteDbHelper.instance.insert({
      NoteDbHelper.coltittle: tittle,
      NoteDbHelper.coldescription: description,
      NoteDbHelper.coldate: DateTime.now().toString(),
    });
  }

  updatedatabase(snap, index, tittle, description) {
    NoteDbHelper.instance.update({
      NoteDbHelper.colid: snap.data![index][NoteDbHelper.colid],
      NoteDbHelper.coltittle: tittle,
      NoteDbHelper.coldescription: description,
      NoteDbHelper.coldate: DateTime.now().toString(),
    });
  }

    deletedatabase(snap, index) {
    NoteDbHelper.instance.delete(snap.data![index][NoteDbHelper.colid]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

          backgroundColor: Colors.blueGrey,
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: const Text('Your Notes')
      ),

////////////////////////////////////////////////////

    body:  Padding(

           padding: const EdgeInsets.all(8),

        child:   Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: FutureBuilder(
            future: NoteDbHelper.instance.queryAll(),
            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snap) {
              if (snap.hasData && snap.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        deletedatabase(snap, index);
                      },
                      background: Container(
                          color: Colors.red, child: const Icon(Icons.delete)),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DescriptionNote(
                                    tittle: snap.data![index][NoteDbHelper.coltittle],
                                    description: snap.data![index][NoteDbHelper.coldescription],
                                  );
                                },
                              ),
                            );
                          },
                          leading: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {

                                 // var tittle = '';
                                  // var description = '';

////////////////////////////////////////////////////////////////////

                                    String originalTitle = snap.data![index][NoteDbHelper.coltittle];
                                  String originalDescription = snap.data![index][NoteDbHelper.coldescription];
                                  String newTitle = originalTitle;
                                  String newDescription = originalDescription;

                                  return

                                    AlertDialog(
                                      title: const Text('Edit Note'),
                                      contentPadding: const EdgeInsets.all(5),
                                      content: SingleChildScrollView(
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    newTitle = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: originalTitle,
                                                  ),
                                                  maxLines: null,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    newDescription = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: originalDescription,
                                                    border: const  OutlineInputBorder(),
                                                  ),
                                                  maxLines: null,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (newTitle.trim().isEmpty || newDescription.trim().isEmpty) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Saving Failed'),
                                                    content: const Text('Please fill the title and note.'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else if (newTitle != originalTitle || newDescription != originalDescription) {
                                              updatedatabase(snap, index, newTitle, newDescription);
                                              Navigator.pop(context);
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    );






////////////////////////////////////////////////////////////////////

                                },
                              );
                            },
                            icon:  const Icon(Icons.edit),
                          ),
                          title: Text(snap.data![index][NoteDbHelper.coltittle]),
                          subtitle: Text(snap.data![index][NoteDbHelper.coldescription]),
                          trailing: Text(
                            snap.data![index][NoteDbHelper.coldate]
                                .toString()
                                .substring(0, 10),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('You do not have any note yet.'),
                );
              }
            },
          ),
        ),
      ),



///////////////////////////////////////////////





      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              var title = '';
              var description = '';


              return


                AlertDialog(

                title: const Text('Add New Note'),
                contentPadding: const EdgeInsets.all(5),
                content: SizedBox(
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          title = value;
                        },
                        decoration: const InputDecoration(hintText: 'Title'),
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            description = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Note',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),


                  //////////////////////// validation/ Dialog, SnackBar ///////////////////

                  TextButton(

                    onPressed: () {
                      if (title.trim().isEmpty || description.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Saving Failed'),
                              content: const Text('Please fill the title and Note.'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],  //mohammed hadi ali
                            );
                          },
                        );
                      } else {
                        insertdatabase(title, description);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),


                  ////////////////////////////// validation //////////////////////////

                ],

              );

            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white,),
      ),


      /////////////////////////////////////////////////////////

    );
  }
}