import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_app/repository/bloc/status_bloc.dart';
import 'package:status_app/screens/screen_status/widget_cards/others_status.dart';
import 'package:status_app/screens/screen_status/widget_cards/own_status.dart';
import 'package:status_app/screens/screen_status/widget_cards/status_viw.dart';

import '../../model/ModelClassStatus.dart';

class ScreenStatus extends StatefulWidget {
  const ScreenStatus({Key? key}) : super(key: key);

  @override
  State<ScreenStatus> createState() => _ScreenStatusState();
}

class _ScreenStatusState extends State<ScreenStatus> {
  late List<ModelClassStatus> modelClassStatus;
  late List<ModelClassStatus> filterList;
  // late List<int> uniqList = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<StatusBloc>(context).add(FetchStatus());
    //badgeHandling();
    //  BlocProvider.of<StatusBloc>(context).add(FetchImage(personId: null));

    super.initState();
  }

  // Future badgeHandling() async {
  //   SharedPreferences prfs = await SharedPreferences.getInstance();
  //   customList = await prfs.getStringList('seen')!;
  // }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Colors.yellow,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey[100],
          onPressed: () {
            BlocProvider.of<StatusBloc>(context).add(FetchStatus());
          },
          child: Icon(
            Icons.refresh,
            color: Colors.blueGrey[900],
          ),
        ),
        appBar: AppBar(
          leadingWidth: mWidth * .2,
          elevation: 0,
          backgroundColor: Color(0xff128C7E),
          leading: Padding(
            padding: EdgeInsets.only(left: mWidth * .04, top: mHeight * .02),
            child: Text(
              "Stories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        body: BlocBuilder<StatusBloc, StatusState>(builder: (context, state) {
          if (state is StatusLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is StatusLoaded) {
            modelClassStatus =
                BlocProvider.of<StatusBloc>(context).modelClassStatus;
            filterList = BlocProvider.of<StatusBloc>(context).modelClassStatus;

            return Column(
              children: [
                // SizedBox(
                //   height: mHeight * .02,
                // ),
                OwnStatus(),
                Container(
                  height: mHeight * .05,
                  width: mWidth,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mWidth * .03, vertical: mHeight * .01),
                    child: Text(
                      "Recent updates",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //OthersStatus()
                Expanded(
                  child: ListView.separated(
                    itemCount: modelClassStatus.length,
                    itemBuilder: (ctx, index) {
                      // uniqList =       modelClassStatus[index].profile!.id!.toInt() ;
                      return GestureDetector(
                        onTap: () {
                          print(
                              "!@!@${modelClassStatus[index].profile!.id.toString()}");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => StatusView(
                                  id: modelClassStatus[index]
                                      .profile!
                                      .id!
                                      .toInt())));
                        },
                        child: OthersStatus(
                          statusCount:
                              // customList.contains(
                              //             modelClassStatus[index].id.toString()) ==
                              //         modelClassStatus[index].profile!.id
                              //     ?
                              //     modelClassStatus
                              //         .where((element) =>
                              //             element.profile!.id ==
                              //             modelClassStatus[index].profile!.id)
                              //         .toList()
                              //         .length
                              //     : modelClassStatus
                              //             .where((element) =>
                              //                 element.profile!.id ==
                              //                 modelClassStatus[index].profile!.id)
                              //             .toList()
                              //             .length -
                              //         1,

                              modelClassStatus
                                  .where((element) =>
                                      element.profile!.id ==
                                      modelClassStatus[index].profile!.id)
                                  .toList()
                                  .length,
                          name:
                              modelClassStatus[index].profile!.name.toString(),
                          imageUrl:
                              modelClassStatus[index].profile!.image.toString(),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return Divider();
                    },
                  ),
                )
              ],
            );
          }
          if (state is StatusError) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<StatusBloc>(context).add(FetchStatus());
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * .9,
                  // color: Colors.red,
                  child: Center(
                    child: Text("something went wrong"),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text("Loading..."),
          );
        }));
  }
}
