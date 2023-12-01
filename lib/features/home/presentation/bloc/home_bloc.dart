import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeScreenChangedState()) {
    on<ChangePageEvent>((event, emit) {
      emit(HomeScreenChangedState(currentIndex: event.currentIndex));
    });
  }
}
