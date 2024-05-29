
import 'package:equatable/equatable.dart';

abstract class RegionEvent extends Equatable {}

class RegionCallEvent extends RegionEvent {
  @override
  List<Object?> get props => [];
}

class SearchRegionCallEvent extends RegionEvent {
  final String searchTitle;

  SearchRegionCallEvent({required this.searchTitle});

  @override
  List<Object?> get props => [searchTitle];
}

class SaveSearchRegion extends RegionEvent {
  final String searchTitle;

  SaveSearchRegion({required this.searchTitle});


  @override
  List<Object?> get props => [];
}

class GetSaveSearchRegion extends RegionEvent {
  @override
  List<Object?> get props => [];
}

class DeleteSaveSearchRegion extends RegionEvent {
  @override
  List<Object?> get props => [];
}