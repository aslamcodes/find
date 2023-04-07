import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _searchResults = [];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .get()
        .then((querySnapshot) {
      setState(() {
        _searchResults = querySnapshot.docs;
      });
    });
  }

  Widget _buildSearchResultItem(BuildContext context,
      QueryDocumentSnapshot<Map<String, dynamic>> userSnapshot) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userSnapshot['profile_picture']),
      ),
      title: Text(userSnapshot['username']),
      trailing: GestureDetector(
        onTap: () async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('friends')
              .doc(userSnapshot.id)
              .set({});
        },
        child: IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.userPlus,
              size: 16,
              color: Color.fromRGBO(0, 129, 159, 1),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,
                color: Color.fromRGBO(0, 129, 159, 1))),
        backgroundColor: Colors.transparent,
        actions: const [],
        shadowColor: Colors.transparent,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              color: const Color.fromRGBO(0, 129, 159, 1),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          autofocus: true,
          onChanged: _onSearchChanged,
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Center(
                  child: Text(
                "Search finders",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(0, 129, 159, 1),
                )),
              )),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildSearchResultItem(context, _searchResults[index]);
              },
            ),
    );
  }
}
