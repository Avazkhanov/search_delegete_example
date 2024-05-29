import 'package:equatable/equatable.dart';
import 'package:search_delegete_example/data/model/region_model.dart';

import '../../data/model/forms_status/forms_satatus.dart';

class RegionState extends Equatable {
  final FormsStatus formsStatus;
  final String errorText;
  final String statusMessage;
  final List<RegionModel> regions;
  final List<RegionModel> currentRegions;
  final List<String> savedRegions;

  const RegionState({
    required this.formsStatus,
    required this.errorText,
    required this.statusMessage,
    required this.currentRegions,
    required this.regions,
    required this.savedRegions,
  });

  RegionState copyWith({
    FormsStatus? formsStatus,
    String? errorText,
    String? statusMessage,
    List<RegionModel>? regions,
    List<RegionModel>? currentRegions,
    List<String>? savedRegions,
  }) {
    return RegionState(
      formsStatus: formsStatus ?? this.formsStatus,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      currentRegions: currentRegions ?? this.currentRegions,
      regions: regions ?? this.regions,
      savedRegions: savedRegions ?? this.savedRegions,
    );
  }

  @override
  List<Object?> get props => [
    formsStatus,
    errorText,
    statusMessage,
    currentRegions,
    regions,
    savedRegions,
  ];
}
