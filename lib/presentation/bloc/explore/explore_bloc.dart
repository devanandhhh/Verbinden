import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/explore_repo/explore_repo.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreFetchEvent>(onExploreFetched);
  }
ExploreService service =ExploreService();
  FutureOr<void> onExploreFetched(
      ExploreFetchEvent event, Emitter<ExploreState> emit) async {
        emit(ExploreLoadingState());
        try {
          print('one');
          List<OthersPost>exploreData =await service.getExplore();
          print('two');
          log('explore data feched $exploreData');
          emit(ExploreLoadedState(exploreData: exploreData));

        } catch (e) {
          log('$e erro catched by onbloc explore');
          emit(ExploreFaliureState(e.toString()));
          
        }
      }
}
