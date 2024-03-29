part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _MapStateInitial;
  const factory MapState.loading() = _MapStateLoading;
  const factory MapState.loaded({
    required List<MapPoint> mapPoints,
    required gm.LatLngBounds visibleRegion,
    required List<MapMarker> markers,
    @Default(ClubFilters(favorite: false)) ClubFilters filters,
  }) = _MapStateLoaded;
  const factory MapState.error() = _MapStateError;
}
