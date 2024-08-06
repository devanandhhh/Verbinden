import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/home_repo/home_repo.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
   on<HomeFetchPostEvent>(onHomeFetchPostEvent);
  }

  HomePageService service =HomePageService();

  FutureOr<void> onHomeFetchPostEvent(HomeFetchPostEvent event, Emitter<HomeState> emit)async {
    emit(HomeLoadingState());
    try {
      log('Feching homeScreen');
      List<OthersPost> othersPost =await service.getAllPost(); 
      log('feched $othersPost');
      emit(HomeLoadedState(othersPost: othersPost));
    } catch (e) {
      log(e.toString());
      emit(HomeFaliureState(e.toString()));
    }
  }
}
