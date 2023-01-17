

import 'package:flutter/material.dart';
import 'blocs/app_blocs.dart';
import 'blocs/app_events.dart';
import 'blocs/app_states.dart';
import 'some/a.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




List<contact>userList=[];
List<String>arr=[];
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


class Home extends StatefulWidget{

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool issorted=false;
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context)=>UserBloc(
        RepositoryProvider.of<a>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
          appBar: AppBar(title: Text("CONTACTS"),
            actions: [
              IconButton(onPressed:()=>setState(() {
                arr.sort();
                issorted=!issorted;
              }), icon: Icon(Icons.compare_arrows)),
              IconButton(
                onPressed: () {
                  // method to show the search bar
                  showSearch(
                      context: context,
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate()
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],

          ),
          body: BlocBuilder<UserBloc,UserState>(
              builder:(context,state){
                if(state is UserLoadingState){
                  return const Center(child:CircularProgressIndicator(),);
                }

                if(state is UserLoadedState){
                  userList=state.users;
                  if(issorted){
                  userList.sort(((a, b) => a.name.compareTo(b.name)));}

                  return ListView.builder(itemCount:userList.length,

                      itemBuilder:(_,index){
                        if(!arr.contains(userList[index].name))arr.add(userList[index].name);
                        return Card(
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical:10),
                            child:ListTile(
                              title: Text(userList[index].name,style:const TextStyle(color: Colors.white)),
                              subtitle: Text(userList[index].phone,style:const TextStyle(color: Colors.white)),
                              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(userList[index].name,userList[index].phone,userList[index].email,userList[index].website))),
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
    print(name);
    this.name=name;
    //if(!arr.contains(name))arr.add(name);
    this.mobnum=mobnum;
    this.email=email;
    this.place=place;
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("DETAILS",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),
          centerTitle: true,

        ),
        body:Column(children: [Container(child: Image.asset('asset/man-gcde00a130_1280.png',height: 200),margin: EdgeInsets.all(50),) ,
          Container(child: Text("NAME: ${this.name}\n\n\nMOBILE NUMBER: ${this.mobnum}\n\n\nE-MAIL: ${this.email}\n\n\nWEBSITE: ${this.place}",
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45),),
            margin: EdgeInsets.fromLTRB(0,0,0,150),
            padding: EdgeInsets.fromLTRB(20,10,0,10),

          ),
        ],mainAxisAlignment: MainAxisAlignment.center,),),

    );
  }

}


class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying


// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),

      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in arr) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        int abd=arr.indexOf(result);
        return ListTile(
          title: Text(result),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(userList[abd].name,userList[abd].phone,userList[abd].email,userList[abd].website))),

        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in arr) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        int abd=arr.indexOf(result);
        return ListTile(
          title: Text(result),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(userList[abd].name,userList[abd].phone,userList[abd].email,userList[abd].website))),

        );
      },
    );
  }
}
