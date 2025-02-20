import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location.dart' as location;

class SavedLocationsWidget extends StatelessWidget {
  const SavedLocationsWidget(
      {super.key,
      required List<location.Location> locations,
      required Function setLocation,
      required Function deleteLocation,
      required bool editMode})
      : _locations = locations,
        _setLocation = setLocation,
        _deleteLocation = deleteLocation,
        _editMode = editMode;

  final List<location.Location> _locations;
  final Function _setLocation;
  final Function _deleteLocation;
  final bool _editMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _locations
          .map((loc) => _editMode
              ? SavedLocationEditWidget(loc: loc, delete: _deleteLocation)
              : SavedLocationWidget(loc: loc, setLocation: _setLocation))
          .toList(),
    );
  }
}

class SavedLocationWidget extends StatelessWidget {
  const SavedLocationWidget(
      {super.key,
      required location.Location loc,
      required Function setLocation})
      : _loc = loc,
        _setLocation = setLocation;

  final location.Location _loc;
  final Function _setLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _setLocation(_loc);
        },
        child: Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                width: 250,
                child: Text("${_loc.city}, ${_loc.state} ${_loc.zip}")),
          ),
        ));
  }
}

class SavedLocationEditWidget extends StatelessWidget {
  const SavedLocationEditWidget(
      {super.key, required location.Location loc, required Function delete})
      : _loc = loc,
        _delete = delete;

  final location.Location _loc;
  final Function _delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.red, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${_loc.city}, ${_loc.state} ${_loc.zip}"),
                GestureDetector(
                    onTap: () {
                      _delete(_loc);
                    },
                    child: Icon(Icons.delete, color: Colors.red))
              ],
            )),
      ),
    );
  }
}
