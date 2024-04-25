class Task{
  String name;
  String? priority;
  String description;
  DateTime date;
  bool isDone;

  Task(this.name,this.priority ,this.description, this.date, this.isDone );

  factory Task.fromJson(Map<String,dynamic> map ) {
    return Task(
     map['name'],
     map['priority'],
     map['description'],
     map['date'],
     map['isDone']
    );
  }
  }