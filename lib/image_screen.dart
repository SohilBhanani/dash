import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),

        itemBuilder: (BuildContext context, int index) {
          return RoundedCornerItem(index+1);
        });
  }


}

class RoundedCornerItem extends StatefulWidget {
  int _index;
  

  RoundedCornerItem(int index) {
    this._index = index;
  }

  @override
  _RoundedCornerItemState createState() => _RoundedCornerItemState();
}

class _RoundedCornerItemState extends State<RoundedCornerItem> {
  Uint8List imageFile;
  StorageReference photosReferance =
  FirebaseStorage.instance.ref().child("photos");
  
  getImage(){
    int MAX_SIZE = 7*1024*1024;
    photosReferance.child("f${widget._index}.jpg").getData(MAX_SIZE).then((data){
    this.setState((){
      imageFile = data;
    });
    }).catchError((error){

    });
  }

//  Widget decideRoundedCornerItem(){
//    if(imageFile == null)
//      {
//        return Center(child: Text("NO data"),);
//      }
//    else
//      {
//        return Image.memory(imageFile,fit: BoxFit.cover,);
//      }
//  }

  Widget CircularItem() {
    if(imageFile==null){
      return Center(child: Text("NO data"),);
    }
    else {
      return Stack(
        children: <Widget>[
           Container(
              height: 230.0,
             child: ClipRRect(

                 borderRadius: BorderRadius.circular(10.0),
                   child: GestureDetector(
                     child: Hero(
                       tag: widget._index,
                       child: Image.memory(
                         imageFile,fit: BoxFit.cover,
                       ),
                     ),
                     onTap: (){
                       Navigator.of(context).push(
                         MaterialPageRoute(
                             builder: (context) => Material(
                               child: Scaffold(
                                 backgroundColor: Colors.transparent,
                                 appBar: AppBar(
                                   title: Text("${widget._index}.jpg"),
                                 ),
                                 body: ListView(
                                   children: <Widget>[
                                     Hero(
                                       tag: widget._index,
                                       child: Image.memory(imageFile),
                                     ),
                                     SizedBox(
                                       height: 10.0,
                                     ),
                                     RaisedButton(
                                       onPressed: (){},
                                       child: Text("Set As Wallpaper"),
                                     )
                                   ],
                                 ),
                               ),
                             )
                         )
                       );
//                       Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => Material(
//                                 child: Scaffold(
//                                 appBar: AppBar(
//                                 title: Text("Image: " + f["img"]),
//                           ),
//                           backgroundColor: Colors.black,
//                           body: Center(
//                           child: Hero(
//                           tag: '$index',
//                           child: Image.asset(
//                           f["img"],
//                           fit: BoxFit.cover,
//                       ),
//                       ),
//                       ),
//
                     },
                   ),



             ),
            ),


//favourite section

//          Align(
//            alignment: Alignment.bottomRight,
//            child: Container(
//              height: 40.0,
//              width: 40.0,
//              child: IconButton(
//                icon: Icon(
//                  Icons.favorite,
//                  size: 25.0,
//                  color: Colors.red,
//                ),
//                onPressed: () {},
//              ),
//            ),
//          ),
        ],
      );
    }
  }

  @override
  void initState(){
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return CircularItem();
  }
}
