import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailTVShowPage extends StatefulWidget {
  final Map<String, dynamic> tvShow;

  const DetailTVShowPage({Key? key, required this.tvShow}) : super(key: key);

  @override
  _DetailTVShowPageState createState() => _DetailTVShowPageState();
}

class _DetailTVShowPageState extends State<DetailTVShowPage> {
  late List<dynamic> _genres;

  @override
  void initState() {
    super.initState();
    _genres = [];
    _fetchGenres();
  }

  void _fetchGenres() async {
    final http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/tv/list?api_key=481bd6077b5ecae8559330454a45470a'),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    setState(() {
      _genres = responseBody['genres'];
    });
  }

  List<String> getGenres() {
    List<String> genreNames = [];
    if (_genres.isNotEmpty) {
      for (var genreId in widget.tvShow['genre_ids']) {
        final genre = _genres.firstWhere((genre) => genre['id'] == genreId, orElse: () => null);
        if (genre != null) {
          genreNames.add(genre['name']);
        }
      }
    }
    return genreNames;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genreNames = getGenres();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tvShow['name']),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.tvShow['poster_path'] != null) // Tambahkan kondisi jika ada poster
                Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.tvShow['poster_path']}',
                  height: 300,
                ),
              SizedBox(height: 10),
              Text(
                'Genre: ${genreNames.isNotEmpty ? genreNames.join(', ') : 'N/A'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Overview: ${widget.tvShow['overview']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Vote Average: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  Text(
                    ' ${widget.tvShow['vote_average']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
