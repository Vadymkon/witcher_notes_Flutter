import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../generated/l10n.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  List witcher_notes = [];

  String _userToDo = "";

  @override
  void initState()
  {
    super.initState();
    witcher_notes.addAll(['First thing','Buy картошка', 'Somethink']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).meow_message),centerTitle: true,
        actions: [IconButton(onPressed: (){;}, icon: Icon(Icons.menu))],),
      body: ListView.builder(itemCount: witcher_notes.length ,itemBuilder: (BuildContext context, int index){
        return Dismissible( //смахивалка
            key: Key(witcher_notes[index]),
            child: Card(
              child: ListTile(
                title: AutoSizeText(maxLines: 1,witcher_notes[index]),
                trailing: IconButton(
                    icon: Icon(Icons.delete_outline_sharp),
                    onPressed: (){setState(() {witcher_notes.removeAt(index);});},
              ),
            ),
            ),
          onDismissed: (direction){
              //if (direction == DismissDirection.endToStart)
                setState(() {
                  witcher_notes.removeAt(index);
                });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context)
          {
            return AlertDialog(
              title: AutoSizeText(maxLines: 1,S.of(context).meow_message),
              content: TextField(
                onChanged: (String value){
                _userToDo = value;
              },),
              actions: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    witcher_notes.add(_userToDo);
                  });
                  Navigator.of(context).pop();
                }, child: AutoSizeText(maxLines: 1,S.of(context).meow_message))
              ],
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
