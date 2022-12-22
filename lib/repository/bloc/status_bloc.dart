import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/ModelClassStatus.dart';
import '../api/status_Api.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  late List<ModelClassStatus> modelClassStatus;
  // late List<ModelClassStatus> filterList;
  // late List uniqList = [];
  late List<ModelClassStatus> filterList;

  ApiStatus apiStatus;
  StatusBloc(this.apiStatus) : super(StatusInitial()) {
    on<FetchStatus>((event, emit) async {
      // TODO: implement event handler
      emit(StatusLoading());
      try {
        modelClassStatus = await apiStatus.getStatus();
        // filterList = modelClassStatus.toList().toSet().toList();

        ///
        //filterList = modelClassStatus;
        // for (int i = 1; modelClassStatus.length > i; i++) {
        //   filterList.removeWhere(
        //       (element) => element.profile!.id == filterList[i].profile!.id);
        //   print("!!$i");
        //   print("####$filterList");
        // }
        ///

        // for (final sett in modelClassStatus) {
        //   if (!filterList.contains(sett)) {
        //     filterList.add(sett);
        //   }
        // }

        ///

        // var sett = <dynamic>{};
        // uniqList =
        //     modelClassStatus.where((element) => sett.add(element.profile!.name == modelClassStatus[])).toList();
        // uniqList = sett.toList();
        // print("@@$modelClassStatus");
        ///
        //  print("#$filterList");
        emit(StatusLoaded());
      } catch (e) {
        print("***$e");
        emit(StatusError());
      }
    });

    on<FetchImage>((event, emit) async {
      // TODO: implement event handler
      emit(ImageLoading());
      try {
        modelClassStatus = await apiStatus.getStatus();

        for (int i = 1; modelClassStatus.length > i; i++) {
          filterList = modelClassStatus
              .where((element) => element.profile!.id == event.personId)
              .toList();
          print("!!$i");
        }
        print("####$filterList");

        // trendWeek = modelClassProductDetails
        //     .where((element) => element.status == "trending")
        //     .toList();
        //
        //
        ///
        // print("#$filterList");
        emit(ImageLoaded());
      } catch (e) {
        print("***$e");
        emit(ImageError());
      }
    });
  }
}
