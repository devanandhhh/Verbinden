import 'package:bloc/bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState(0));

  void updateIndex(int index){
    emit(BottomNavState(index));
  }
}
