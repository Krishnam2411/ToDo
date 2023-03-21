import 'package:flutter/material.dart';
import '../model/todo.dart';


const Color black = Color(0xFF3A3A3A);

const Color textColor = Color(0xFFFFFFFF);
const Color tBar = Color.fromRGBO(95, 82, 238, 1);
const Color listColor = Color(0xFFF8F8F8);
const Color bgColor = Color(0xFF727272);


class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItems;
  const ToDoItem({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItems}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        tileColor: listColor,
        leading: Icon(todo.isdone?Icons.check_circle:Icons.circle_outlined, color: tBar),
        title: Text(todo.desc,  style: TextStyle(fontSize:20 , color: black, decoration: todo.isdone? TextDecoration.lineThrough: null),),
      ),
    );
  }
}

class Mainpage extends StatefulWidget {
  Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final todolist=ToDo.ToDoList();

    Widget _buildPopUpDialog(BuildContext ctx) {
    String desc = "";
    return AlertDialog(
      title: const Text('What ToDo?  🤔'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => desc = value,
            )
          ]),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                ToDo newTodo =
                    ToDo(desc: desc);
                todolist.add(newTodo);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Submit', style: TextStyle(color: tBar, fontSize: 18),),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),backgroundColor: tBar,),
      backgroundColor: bgColor,
      body: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 20, right: 20, left: 20),
        child: ListView(
          children: [
            for (ToDo todo in todolist)
              ToDoItem(todo: todo,
              onToDoChanged: _handleToDoChange,
              onDeleteItems: (){},
              ) 
          ],
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
          backgroundColor: tBar,
          onPressed: () => showDialog(
            context: context,
            builder: ((ctx) => _buildPopUpDialog(ctx)),
          ),
          child: const Icon(Icons.add, size:40,),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
          backgroundColor: tBar,
          onPressed: () => _deleteToDoItems(),
          child: const Icon(Icons.delete_forever, size:40,),
          ),
        ],
      )
    );
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isdone=!todo.isdone;
    });
  }
  void _deleteToDoItems(){
    setState(() {
      todolist.removeWhere((item) => item.isdone==true);
    });
  }
}