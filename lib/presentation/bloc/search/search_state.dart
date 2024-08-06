part of 'search_bloc.dart';


abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState{

}
class SearchGridViewState extends SearchState{
  //do 
}
class SearchListViewState extends SearchState{
final List<GetSearchResult>getResult ;
SearchListViewState({required this.getResult});
}
class SearchFaliureState extends SearchState{
  final String error;
  SearchFaliureState(this.error);
}