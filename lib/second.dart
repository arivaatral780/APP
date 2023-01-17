

import 'package:flutter/material.dart';
import 'blocs/app_blocs.dart';
import 'blocs/app_events.dart';
import 'blocs/app_states.dart';
import 'some/a.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext){
    return MaterialApp(
        home: RepositoryProvider(
          create: (context) =>  a(),
          child: Home(),
        )
    );
  }
}


class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context)=>UserBloc(
        RepositoryProvider.of<a>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
          appBar: AppBar(title: Text("CONTACTS"),),
          body: BlocBuilder<UserBloc,UserState>(
              builder:(context,state){
                if(state is UserLoadingState){
                  return const Center(child:CircularProgressIndicator(),);
                }
                if(state is UserLoadedState){
                  List<contact>userList=state.users;
                  return ListView.builder(itemCount:userList.length,
                      itemBuilder:(_,index){
                        return Card(
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical:10),
                            child:ListTile(
                              title: Text(userList[index].name,style:const TextStyle(color: Colors.white)),
                              subtitle: Text(userList[index].phone,style:const TextStyle(color: Colors.white)),
                              trailing: CircleAvatar(),
                              onTap: ()=>Details(userList[index].name,userList[index].phone ,userList[index].email ,userList[index].website),
                            )
                        );
                      });
                }
                return Container();
              }
          )
      ),
    );
  }
}

class Details extends StatelessWidget{
  @override
  var name,mobnum,email,place;
  Details(name,mobnum,email,place){
    print("hiiiiii");
    this.name=name;
    this.mobnum=mobnum;
    this.email=email;
    this.place=place;
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("DETAILS",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),centerTitle: true,),
        body:Column(children: [Icon(Icons.person,size: 250,),Container(child: Text("NAME",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),decoration: BoxDecoration(color: Colors.cyan),margin: EdgeInsets.fromLTRB(0,0,0,0),),
          Container(child: Text("${this.name}",style: TextStyle(fontSize: 20),),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,0,0,0),),
          Container(child: Text("MOBILE NUMBER",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,20,0,0),),
          Container(child: Text("${this.mobnum}",style: TextStyle(fontSize: 20)),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,0,0,0),),
          Container(child: Text("E-MAIL",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,20,0,0),),
          Container(child: Text("${this.email}",style: TextStyle(fontSize: 20)),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(40,0,0,0),),
          Container(child: Text("PLACE",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,20,0,0),),
          Container(child: Text("${this.place}",style: TextStyle(fontSize: 20)),decoration: BoxDecoration(),margin: EdgeInsets.fromLTRB(0,0,0,40),),

        ],mainAxisAlignment: MainAxisAlignment.center,),),

    );
  }

}
