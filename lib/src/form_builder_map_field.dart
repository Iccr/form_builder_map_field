import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormBuilderMapField extends FormBuilderField<CameraPosition> {
  final IconData markerIcon;
  final double markerIconSize;
  final Color markerIconColor;
  final MapType mapType;
  final double height;
  final bool myLocationButtonEnabled;
  final bool myLocationEnabled;
  final bool zoomGesturesEnabled;
  final Set<Marker> markers;
  final void Function(LatLng) onTap;
  final EdgeInsets padding;
  final bool buildingsEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final Set<Circle> circles;
  final bool compassEnabled;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final bool indoorViewEnabled;
  final bool mapToolbarEnabled;
  final MinMaxZoomPreference minMaxZoomPreference;
  final void Function() onCameraIdle;
  final void Function() onCameraMoveStarted;
  final void Function(LatLng) onLongPress;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool trafficEnabled;

  FormBuilderMapField({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator<CameraPosition> validator,
    CameraPosition initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<CameraPosition> onChanged,
    FormFieldSetter<CameraPosition> onSaved,
    bool enabled = true,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    ValueTransformer<CameraPosition> valueTransformer,
    this.markerIcon = Icons.person_pin_circle,
    this.markerIconSize = 30,
    this.markerIconColor = Colors.black,
    this.height = 300,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.markers,
    this.onTap,
    this.circles,
    this.gestureRecognizers,
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onLongPress,
    this.polygons,
    this.polylines,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<CameraPosition> field) {
            final _markerKey = GlobalKey();
            final _controllerCompleter = Completer<GoogleMapController>();
            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: enabled,
                errorText: field.errorText,
              ),
              child: Container(
                height: height,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var maxWidth = constraints.biggest.width;
                    var maxHeight = constraints.biggest.height;

                    return Stack(
                      children: <Widget>[
                        Container(
                          height: maxHeight,
                          width: maxWidth,
                          child: GoogleMap(
                            initialCameraPosition: initialValue,
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controllerCompleter.isCompleted) _controllerCompleter.complete(controller);
                            },
                            onCameraMove: (CameraPosition newPosition) {
                              field.didChange(newPosition);
                            },
                            mapType: mapType,
                            myLocationButtonEnabled: myLocationButtonEnabled,
                            myLocationEnabled: myLocationEnabled,
                            zoomGesturesEnabled: zoomGesturesEnabled,
                            markers: markers,
                            onTap: onTap,
                            padding: padding,
                            buildingsEnabled: buildingsEnabled,
                            cameraTargetBounds: cameraTargetBounds,
                            circles: circles,
                            compassEnabled: compassEnabled,
                            gestureRecognizers: gestureRecognizers,
                            indoorViewEnabled: indoorViewEnabled,
                            mapToolbarEnabled: mapToolbarEnabled,
                            minMaxZoomPreference: minMaxZoomPreference,
                            onCameraIdle: onCameraIdle,
                            onCameraMoveStarted: onCameraMoveStarted,
                            onLongPress: onLongPress,
                            polygons: polygons,
                            polylines: polylines,
                            rotateGesturesEnabled: rotateGesturesEnabled,
                            scrollGesturesEnabled: scrollGesturesEnabled,
                            tiltGesturesEnabled: tiltGesturesEnabled,
                            trafficEnabled: trafficEnabled,
                          ),
                        ),
                        Positioned(
                          bottom: maxHeight / 2,
                          right: (maxWidth - markerIconSize) / 2,
                          child: Container(
                            key: _markerKey,
                            child: Icon(
                              markerIcon,
                              size: markerIconSize,
                              color: markerIconColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );

  @override
  _FormBuilderMapFieldState createState() => _FormBuilderMapFieldState();
}

class _FormBuilderMapFieldState extends FormBuilderFieldState<FormBuilderMapField, CameraPosition> {}
