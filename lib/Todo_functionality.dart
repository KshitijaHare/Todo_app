import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import 'Todo_model.dart';

class TodoAppUI extends StatefulWidget{
  const TodoAppUI({super.key});

  @override
  State createState() => _TodoAppUIState();

}
class _TodoAppUIState extends State {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  List<ToDoModel> todoCards=[
    ToDoModel(
      title:"Flutter",
      description:"Dart ,stmt.sqflite",
      date:"Aug 17,2025",
    ),
    ToDoModel(
      title:"Java",
      description:"OOP,SpringBoot",
      date:"Aug 18,2025",
    ),
    ToDoModel(
      title:"Python",
      description:"ML,Data Science",
      date:"Aug 19,2025",
    ),
  ];
  List cardColorsList=[
    Color.fromRGBO(250,232,232,1),
    Color.fromRGBO(232,237,250,1),
    Color.fromRGBO(250,249,232,1),
    Color.fromRGBO(250,232,250,1),

  ];
  void clearController () {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }
  void submit(bool doEdit,[ToDoModel? obj]){
    if(titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        dateController.text.isNotEmpty) {
          if(doEdit){
            obj!.title=titleController.text;
            obj.description=descriptionController.text;
            obj.date=dateController.text;
          }else{
            todoCards.add(
              ToDoModel(
                title:titleController.text,
                description:descriptionController.text,
                date:dateController.text,
              ),
            );
          }
          clearController();
          setState( () {} );
          }
          Navigator.of(context).pop();
        }
        void showBottomSheet(bool doEdit,[ToDoModel? obj]) {
          showModalBottomSheet(
            context:context,
            builder:(context){
              return Padding(
                padding:EdgeInsets.all(10),
                child:Column(
                  mainAxisSize:MainAxisSize.min,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children:[
                        Text(
                          "Create To-Do Task",
                          style:GoogleFonts.quicksand(
                            fontSize:22,
                            fontWeight:FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                      SizedBox(height:10),

                      Text(
                        "Title",
                        style:GoogleFonts.quicksand(
                          fontSize:18,
                          color:Color.fromRGBO(2,167,177,1),
                        ),
                      ),
                      //TITLE
                      TextField(
                        controller:titleController,
                        decoration:InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:BorderSide(
                              color:Color.fromRGBO(2,167,177,1),
                               ),
                           ),
                        ),
                      ),
                      SizedBox(height:10),
                      Text(
                        "Description",
                        style:GoogleFonts.quicksand(
                          fontSize:18,
                          color:Color.fromRGBO(2,167,177,1),
                        ),

                      ),
                      TextField(
                        controller:descriptionController,
                        decoration:InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(20),
                            borderSide:BorderSide(
                              color:Color.fromRGBO(2,167,177,1),
                               ),
                            ),

                        ),
                      ),
                      SizedBox(height:10),
                      Text(
                        "Date",
                        style:GoogleFonts.quicksand(
                          fontSize:18,
                          color:Color.fromRGBO(2,167,177,1),

                        ),
                      ),

                      //DATE
                      TextField(
                        controller:dateController,
                        decoration:InputDecoration(
                         border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(
                            color:Color.fromRGBO(2,167,177,1),
                             ),
                           ),
                              suffixIcon:Icon(Icons.calendar_month_outlined), 
                        ),
                        onTap:() async{
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate:DateTime(2025),
                            lastDate:DateTime(2026),
                            );
                            dateController.text=DateFormat.yMMMd().format(pickedDate!);
                        },
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:[
                          ElevatedButton(
                            onPressed:() {
                              if (doEdit) {
                                submit(doEdit,obj);
                              }else{
                                //ADD
                                submit(doEdit);
                              }
                            },
                            style:ButtonStyle(backgroundColor:WidgetStatePropertyAll(
                              Color.fromRGBO(2,167,177,1),

                            ),
                            ),
                            child:Text("Submit"),
                          ),
                        ],
                      ),
                      SizedBox(height:30),

                  ],
                ),

              );
            },
          );
        }
        
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar:AppBar(
      backgroundColor:Color.fromRGBO(2,167,177,1.0),
      title:Text(
        "To-do list",
        style:GoogleFonts.quicksand(
          fontWeight:FontWeight.w700,
          fontSize:30,
          color:Color.fromRGBO(255,255,255,1.0),
        ),
      ),
    ),

    body:ListView.builder(
      itemCount:todoCards.length,
      itemBuilder:(context ,index){
        return Padding(
          padding:EdgeInsets.all(10.0) ,
          child:Container(
            decoration:BoxDecoration(
              color:cardColorsList[index % cardColorsList.length],
              borderRadius:BorderRadius.circular(20),
            ),
            child:Column(
              children: [
                Row(
                  children: [
                    //Icon
                    Container(
                      height:70,
                      width:70,
                      decoration:BoxDecoration(
                        shape:BoxShape.circle,
                        color:Colors.white,

                      ),
                      child:ClipRRect(
                        borderRadius:BorderRadius.circular(30),
                        child:Image.asset("assets/todo.png",
                        fit:BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width:10),
                    //CONTENT
                    Expanded(
                      child:Column(
                        children: [
                          Text(
                            todoCards[index].title,
                            style:GoogleFonts.quicksand(
                              fontSize:18,
                              fontWeight:FontWeight.bold,
                              
                               ),
                          ),
                          Text(
                            todoCards[index].description,
                            style:GoogleFonts.quicksand(
                              fontSize:18,
                              fontWeight:FontWeight.bold,
                            ),

                          ),
                        ],
                        ),
                         ),
                  ],

                  ),
                  Padding(padding: EdgeInsets.all(10),
                  child:Row(
                    children: [
                      Text(
                        todoCards[index].date,
                        style:GoogleFonts.quicksand(
                          fontSize:18,
                          fontWeight:FontWeight.bold,
                        ),

                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          titleController.text=todoCards[index].title;
                          descriptionController.text=todoCards[index].description;
                          dateController.text=todoCards[index].date;
                          showBottomSheet(true,todoCards[index]);
                        },
                        child:Icon(Icons.edit_outlined),
                      ),
                      SizedBox(width:10),
                      GestureDetector(
                        onTap:(){
                          todoCards.remove(todoCards[index]);
                          setState(() {});
                        },
                        child:Icon(Icons.delete_outline_rounded),
                      ),
                    ],
                  ),
                  ),
              ],
            ),
          ),
        );
      },
    ),
    floatingActionButton:FloatingActionButton(
      onPressed:(){
        clearController();
        showBottomSheet(false);
      } ,
      backgroundColor:Color.fromRGBO(2,167,177,1),
      child:Icon(Icons.add),
    ),
    );
  }
        }


        




                        
                        
                        