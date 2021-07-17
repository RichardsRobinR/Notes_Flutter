import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UiNotes extends StatelessWidget {
  const UiNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          staggeredTileBuilder: (i) => StaggeredTile.fit(2),

          itemCount:5,
          itemBuilder: (context,index) {



            return Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title',

                      style: TextStyle(
                          fontSize: 25
                      ),),
                    Text('description',
                      maxLines: 10,
                      style :TextStyle(
                          fontSize: 20
                      ),),
                  ],
                ),
              ),
            );
          } ),

      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
