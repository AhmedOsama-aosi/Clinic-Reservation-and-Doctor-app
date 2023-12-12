abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteLoadingState extends FavoriteStates {}

class GetFavoriteDataState extends FavoriteStates {}

class PatchFavoriteDataState extends FavoriteStates {
  PatchFavoriteDataState(favoriteCubit) {
    favoriteCubit.getFavoriteData();
  }
}

class AssignDoctorsDataState extends FavoriteStates {}

class EditFavoriteState extends FavoriteStates {
  EditFavoriteState();
  // EditFavoriteState({favoriteCubit, userid}) {
  //   favoriteCubit.patchFavoritedata(userid);
  // }
}

class ErrorPatchFavoriteDataState extends FavoriteStates {}

class ErrorGetFavoriteDataState extends FavoriteStates {
  // final String? error;
  // ErrorGetFavoriteDataState(this.error);
}
