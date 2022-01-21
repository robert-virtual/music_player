import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel>? songs;
  bool status = false;
  @override
  void initState() {
    super.initState();
    findSongs();
  }

  void findSongs() async {
    // DEFAULT:
    // SongSortType.TITLE,
    songs = await _audioQuery.querySongs( sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,);
    setState(() {
      status = true;
    });
    // OrderType.ASC_OR_SMALLER,
    // UriType.EXTERNAL,
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Songs $status'),
        ),
        body: !status
            ? const Center(child: CircularProgressIndicator())
            : songs == null
                ? const Center(
                    child: Text("Ups ha habido un error"),
                  )
                : Text("Hay datos ${songs!.length}"));

    /*FutureBuilder<List<SongModel>>(
            future: songs,
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, i) {
                      final item = snap.data![i];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text("${item.duration}"),
                      );
                    });
              }
              if (snap.hasError) {
                return const Center(
                  child: Text("Ups ha habido un  error"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));*/
  }
}
