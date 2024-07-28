import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uber_clone/core/screat/api_key.dart';

class SearchBoxPlace extends StatefulWidget {
  final Function(Prediction prediction) prediction;
  const SearchBoxPlace({super.key, required this.prediction});

  @override
  State<SearchBoxPlace> createState() => _SearchBoxPlaceState();
}

class _SearchBoxPlaceState extends State<SearchBoxPlace> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      textStyle: TextStyle(color: Colors.black),
      googleAPIKey: googgle_api_key,
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        fillColor: Colors.white,
        filled: true,
        hintText: "Enter the city ",
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(Icons.location_on),
      ),
      debounceTime: 800, // default 600 ms,
// optional by default null is set
      isLatLngRequired: true, // if you required coordinates from place detail
      getPlaceDetailWithLatLng: widget.prediction, // this callback is called when isLatLngRequired is true
      itemClick: (Prediction prediction) {
        controller.text = prediction.description!;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description!.length));
      },
      // if we want to make custom list item builder
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 7,
              ),
              Expanded(child: Text(prediction.description ?? ""))
            ],
          ),
        );
      },
      // if you want to add seperator between list items
      seperatedBuilder: Divider(),
      // want to show close icon
      isCrossBtnShown: true,
      // optional container padding
      containerHorizontalPadding: 10,
    );
  }
}
