part of 'search_bloc.dart';


abstract class SearchEvent {}

class SearchTextChangeEvent extends SearchEvent{
  final String searchText;

  SearchTextChangeEvent({required this.searchText});
  
}