import 'package:riverpod/riverpod.dart';

import '../data/constant.dart';

class PaginationState {
  final int actualPage;
  final int totalPage;
  final int rowPerPage;
  final int totalRows;
  final bool isLoading;
  final String messageKey;

  PaginationState({
    required this.actualPage,
    required this.totalPage,
    required this.rowPerPage,
    required this.totalRows,
    required this.isLoading,
    required this.messageKey,
  });

  PaginationState copyWith({
    int? actualPage,
    int? totalPage,
    int? rowPerPage,
    int? totalRows,
    bool? isLoading,
    String? messageKey,
  }) {
    return PaginationState(
      actualPage: actualPage ?? this.actualPage,
      totalPage: totalPage ?? this.totalPage,
      rowPerPage: rowPerPage ?? this.rowPerPage,
      totalRows: totalRows ?? this.totalRows,
      isLoading: isLoading ?? this.isLoading,
      messageKey: messageKey ?? this.messageKey,
    );
  }
}

class PaginationNotifier extends StateNotifier<Map<String, PaginationState>> {
  PaginationNotifier()
      : super({
          menus[0]: PaginationState(
            actualPage: 0,
            totalPage: 0,
            rowPerPage: 10, // Default rows per page
            totalRows: 0,
            isLoading: false,
            messageKey: '',
          ),
          menus[1]: PaginationState(
            actualPage: 0,
            totalPage: 0,
            rowPerPage: 10,
            totalRows: 0,
            isLoading: false,
            messageKey: '',
          ),
          menus[2]: PaginationState(
            actualPage: 0,
            totalPage: 0,
            rowPerPage: 10,
            totalRows: 0,
            isLoading: false,
            messageKey: '',
          ),
          menus[3]: PaginationState(
            actualPage: 0,
            totalPage: 0,
            rowPerPage: 10,
            totalRows: 0,
            isLoading: false,
            messageKey: '',
          ),
          menus[4]: PaginationState(
            actualPage: 0,
            totalPage: 0,
            rowPerPage: 10,
            totalRows: 0,
            isLoading: false,
            messageKey: '',
          ),
        });

  void updateState(String key, PaginationState newState) {
    state = {
      ...state,
      key: newState,
    };
  }

  void updateActualPage(String key, int page) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      if (page >= 0) {
        updateState(key, currentState.copyWith(actualPage: page));
      } else {
        print('Invalid page number');
      }
    }
  }

  void updateTotalPage(String key, int total) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      updateState(key, currentState.copyWith(totalPage: total));
    }
  }

  void updateRowPerPage(String key, int rows) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      updateState(key, currentState.copyWith(rowPerPage: rows));
    }
  }

  void updateTotalRows(String key, int rows) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      final updatedState = currentState.copyWith(totalRows: rows);
      updateState(key, updatedState);
      calculateTotalPages(key);
    }
  }

  void reset(String key) {
    if (state.containsKey(key)) {
      updateState(
        key,
        PaginationState(
          actualPage: 0,
          totalPage: 0,
          rowPerPage: state[key]!.rowPerPage, // Retain the default rowPerPage
          totalRows: 0,
          isLoading: false,
          messageKey: '',
        ),
      );
    }
  }

  void setLoading(String key, bool loading) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      updateState(key, currentState.copyWith(isLoading: loading));
    }
  }

  void setIsError(String key, String messageKey) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      updateState(key, currentState.copyWith(messageKey: messageKey));
    }
  }

  void calculateTotalPages(String key) {
    if (state.containsKey(key)) {
      final currentState = state[key]!;
      final totalRows = currentState.totalRows;
      final rowPerPage = currentState.rowPerPage;

      if (rowPerPage > 0) {
        final totalPages = (totalRows / rowPerPage).ceil();
        updateState(key, currentState.copyWith(totalPage: totalPages));
      } else {
        print('Invalid pagination data for key $key');
      }
    }
  }
}

final paginationProvider =
    StateNotifierProvider<PaginationNotifier, Map<String, PaginationState>>(
  (ref) => PaginationNotifier(),
);
