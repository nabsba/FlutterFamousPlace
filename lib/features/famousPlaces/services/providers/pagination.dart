import 'package:riverpod/riverpod.dart';

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

class PaginationNotifier extends StateNotifier<PaginationState> {
  PaginationNotifier()
      : super(PaginationState(
          actualPage: 0,
          totalPage: 0,
          rowPerPage: 0,
          totalRows: 0,
          isLoading: false,
          messageKey: '',
        ));

  void updateActualPage(int page) {
    if (page >= 0) {
      state = state.copyWith(actualPage: page);
    } else {
      print('Invalid page number');
    }
  }

  void updateTotalPage(int total) {
    state = state.copyWith(totalPage: total);
  }

  void updateRowPerPage(int rows) {
    state = state.copyWith(rowPerPage: rows);
  }

  void updateTotalRows(int rows) {
    state = state.copyWith(totalRows: rows);
    calculateTotalPages();
  }

  void reset() {
    state = PaginationState(
        actualPage: 0,
        totalPage: 0,
        rowPerPage: state.rowPerPage, // Retain the default rowPerPage
        totalRows: 0,
        messageKey: '',
        isLoading: false);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setIsError(String messageKey) {
    state = state.copyWith(messageKey: messageKey);
  }

  void calculateTotalPages() {
    final totalRows = state.totalRows;
    final rowPerPage = state.rowPerPage;

    if (rowPerPage > 0) {
      final totalPages = (totalRows / rowPerPage).ceil();
      state = state.copyWith(totalPage: totalPages);
    } else {
      print('Invalid pagination data');
    }
  }
}

final paginationProvider =
    StateNotifierProvider<PaginationNotifier, PaginationState>(
  (ref) => PaginationNotifier(),
);
