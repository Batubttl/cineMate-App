import 'package:cinemate_app/init/navigation/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(currentIndex: 0));

  void changeIndex(int index) {
    emit(NavigationState(currentIndex: index));
  }
}
