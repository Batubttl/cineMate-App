// import 'dart:convert';

// import 'package:cinemate_app/data/model/movie_model.dart';
// import 'package:cinemate_app/presentation/watchlist/cubit/watchlist_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class WatchlistCubit extends Cubit<WatchlistState> {
//   final SharedPreferences _prefs;
//   static const String _movieWatchlistKey = 'movie_watchlist';
//   static const String _tvWatchlistKey = 'tv_watchlist';

//   WatchlistCubit(this._prefs) : super(const WatchlistState()) {
//     loadWatchlist();
//   }

//   Future<void> loadWatchlist() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final movieWatchlistJson = _prefs.getString(_movieWatchlistKey);
//       final tvWatchlistJson = _prefs.getString(_tvWatchlistKey);

//       final movieWatchlist = movieWatchlistJson != null
//           ? (json.decode(movieWatchlistJson) as List)
//               .map((item) => MovieResults.fromJson(item))
//               .toList()
//           : [];
//       final tvWatchlist = tvWatchlistJson != null
//           ? (json.decode(tvWatchlistJson) as List)
//               .map((item) => MovieResults.fromJson(item))
//               .toList()
//           : [];

//       emit(state.copyWith(
//         movieWatchlist: movieWatchlist,
//         tvWatchlist: tvWatchlist,
//         isLoading: false,
//       ),);
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: e.toString(),
//       ),);
//     }
//   }

//   Future<void> toggleWatchlist({
//     required MovieResults item,
//     required String mediaType,
//   }) async {
//     try {
//       if (mediaType == 'movie') {
//         final isInWatchlist = state.movieWatchlist?.any(
//               (watchlist) => watchlist.id == item.id,
//             ) ??
//             false;

//         if (isInWatchlist) {
//           final updatedWatchlist = state.movieWatchlist
//               ?.where((watchlist) => watchlist.id != item.id)
//               .toList();
//           await _prefs.setString(
//             _movieWatchlistKey,
//             json.encode(updatedWatchlist?.map((e) => e.toJson()).toList()),
//           );
//           emit(state.copyWith(movieWatchlist: updatedWatchlist));
//         } else {
//           final updatedWatchlist = [...?state.movieWatchlist, item];
//           await _prefs.setString(
//             _movieWatchlistKey,
//             json.encode(updatedWatchlist.map((e) => e.toJson()).toList()),
//           );
//           emit(state.copyWith(movieWatchlist: updatedWatchlist));
//         }
//       } else {}
//     } catch (e) {
//       emit(state.copyWith(errorMessage: e.toString()));
//     }
//   }
// }
