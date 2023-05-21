import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_tv_show.dart';

class TVShowsPage extends StatefulWidget {
  const TVShowsPage({Key? key}) : super(key: key);

  @override
  _TVShowsPageState createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {

  late List<dynamic> _tvShows;
  late List<dynamic> _searchResults;
  late TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tvShows = [];
    _searchResults = [];
    _searchController = TextEditingController();
    _fetchTVShows();
  }

  void _fetchTVShows() async {
    final http.Response response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/popular?api_key=481bd6077b5ecae8559330454a45470a'),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    setState(() {
      _tvShows = responseBody['results'];
    });
  }

  void _searchTVShows(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _searchResults = _tvShows
          .where((tvShow) => tvShow['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetailTVShow(Map<String, dynamic> tvShow) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTVShowPage(tvShow: tvShow),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search TV Shows',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          onChanged: _searchTVShows,
        ) : const Text('TV Shows'),backgroundColor: Colors.blue[900],
        leading: _isSearching ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
              _searchResults.clear();
            });
          },
        ) : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search TV Shows',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _searchTVShows(_searchController.text),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: _isSearching ? _searchResults.length : _tvShows.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> tvShow = _isSearching ? _searchResults[index] : _tvShows[index];
                return GestureDetector(
                  onTap: () => _navigateToDetailTVShow(tvShow),
                  child: GridTile(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${tvShow['poster_path']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
