import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  final bool isUpdating;

  BaseState({
    this.isUpdating = false,
  });

  List<Object> get props => [
    this.isUpdating,
  ];

  BaseState copyWith({
    bool? isLoading,
  }) {
    return BaseState(
      isUpdating: isLoading ?? this.isUpdating,
    );
  }
}

class SavedNewPasswordState extends BaseState{}