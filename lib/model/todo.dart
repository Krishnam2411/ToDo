class ToDo {
  String desc;
  bool isdone;

  ToDo({
    required this.desc,
    this.isdone = false,
  });
  static List<ToDo> ToDoList(){
    return [
      ToDo(desc: 'complete assignments', isdone: true),
      ToDo(desc: 'eat snacks',),
      ToDo(desc: 'complete notes', isdone: true),
      ToDo(desc: 'go for a walk',),
    ];
  }
}