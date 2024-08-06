import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:verbinden/data/api/search_repo/search_repo.dart';
import 'package:verbinden/data/models/get_search_result/get_search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextChangeEvent>(onSearchTextChanged);
  }
SearchService service =SearchService();
  FutureOr<void> onSearchTextChanged(SearchTextChangeEvent event, Emitter<SearchState> emit)async {
    emit(SearchLoadingState());
    if(event.searchText.isEmpty){
      emit(SearchGridViewState());
    }else if(event.searchText.isNotEmpty){
      try{
     // await Future.delayed(const Duration(seconds: 2));
        List<GetSearchResult> getResult =await service.getSearchList(userName: event.searchText);
        log('fetched users $getResult');
        emit(SearchListViewState(getResult: getResult));
      }catch(e){
        log(e.toString());
        emit(SearchFaliureState(e.toString()));
      }
    }
  }
}
