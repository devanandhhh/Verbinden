import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityInitial(isVisible:true ));

  void toggleVisibility(){
    final currentState = state as PasswordVisibilityInitial;
    emit(PasswordVisibilityInitial(isVisible: !currentState.isVisible));
  }
}
