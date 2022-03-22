
import 'package:dr_drivers/address/place_service.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch() {
    apiClient = PlaceApiProvider();
  }

  late PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
//        close(context, null);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(query, "en"),
      builder: (context, snapshot) {
        var data = snapshot.hasData ? snapshot.data as List<Suggestion> : [];
        debugPrint("data=====$data");
        return query == ''
            ? Container(
          padding: EdgeInsets.all(16.0),
          child: Text('Enter your address'),
        )
            : snapshot.hasData
            ? ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text((data[index] as Suggestion).description),
                onTap: () {
                  close(context, data[index] as Suggestion);
                },
              ),
              itemCount: data.length,
            )
            : Container(child: Text('Loading...'));
      }
    );
  }
}