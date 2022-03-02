import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:latlong2/latlong.dart';

class LandPlanningDetailScreen extends StatefulWidget {
  const LandPlanningDetailScreen({Key? key}) : super(key: key);

  @override
  _LandPlanningDetailScreenState createState() =>
      _LandPlanningDetailScreenState();
}

class _LandPlanningDetailScreenState extends State<LandPlanningDetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ArcGIS')),
        body: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(10.757763, 106.540400),
                    zoom: 11.0,
                    plugins: [EsriPlugin()],
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    rotationWinGestures: MultiFingerGesture.none),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                    // tileProvider: CachedNetworkTileProvider(),
                  ),
                  // FeatureLayerOptions(
                  //   "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
                  //   "polygon",
                  //   onTap: (attributes, LatLng location) {
                  //     print(attributes);
                  //   },
                  //   render: (dynamic attributes) {
                  //     // You can render by attribute
                  //     return PolygonOptions(
                  //         borderColor: Colors.blueAccent,
                  //         color: Colors.black12,
                  //         borderStrokeWidth: 2);
                  //   },
                  // ),
                  // FeatureLayerOptions(
                  //   "https://services8.arcgis.com/1p2fLWyjYVpl96Ty/arcgis/rest/services/Forest_Service_Recreation_Opportunities/FeatureServer/0",
                  //   "point",
                  //   render: (dynamic asttributes) {
                  //     // You can render by attribute
                  //     return Marker(
                  //       width: 30.0,
                  //       height: 30.0,
                  //       builder: (ctx) => Icon(Icons.pin_drop),
                  //       point: LatLng(2, 3),
                  //     );
                  //   },
                  //   onTap: (attributes, LatLng location) {
                  //     print(attributes);
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class OverlayImageLayerOptions extends LayerOptions {
  final List<OverlayImage> overlayImages;

  OverlayImageLayerOptions({
    Key? key,
    this.overlayImages = const [],
    Stream<Null>? rebuild,
  }) : super(key: key, rebuild: rebuild);
}

class OverlayImage {
  final LatLngBounds bounds;
  final ImageProvider imageProvider;
  final double opacity;
  final bool gaplessPlayback;

  OverlayImage({
    required this.bounds,
    required this.imageProvider,
    this.opacity = 1.0,
    this.gaplessPlayback = false,
  });
}

class OverlayImageLayerWidget extends StatelessWidget {
  final OverlayImageLayerOptions options;

  OverlayImageLayerWidget({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapState = MapState.maybeOf(context)!;
    return OverlayImageLayer(options, mapState, mapState.onMoved);
  }
}

class OverlayImageLayer extends StatelessWidget {
  final OverlayImageLayerOptions overlayImageOpts;
  final MapState map;
  final Stream<Null>? stream;

  OverlayImageLayer(this.overlayImageOpts, this.map, this.stream)
      : super(key: overlayImageOpts.key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: stream,
      builder: (BuildContext context, _) {
        return ClipRect(
          child: Stack(
            children: <Widget>[
              for (var overlayImage in overlayImageOpts.overlayImages)
                _positionedForOverlay(overlayImage),
            ],
          ),
        );
      },
    );
  }

  Positioned _positionedForOverlay(OverlayImage overlayImage) {
    final zoomScale =
        map.getZoomScale(map.zoom, map.zoom); // TODO replace with 1?
    final pixelOrigin = map.getPixelOrigin();
    final upperLeftPixel =
        map.project(overlayImage.bounds.northWest).multiplyBy(zoomScale) -
            pixelOrigin;
    final bottomRightPixel =
        map.project(overlayImage.bounds.southEast).multiplyBy(zoomScale) -
            pixelOrigin;
    return Positioned(
      left: upperLeftPixel.x.toDouble(),
      top: upperLeftPixel.y.toDouble(),
      width: (bottomRightPixel.x - upperLeftPixel.x).toDouble(),
      height: (bottomRightPixel.y - upperLeftPixel.y).toDouble(),
      child: Image(
        image: overlayImage.imageProvider,
        fit: BoxFit.fill,
        color: Color.fromRGBO(255, 255, 255, overlayImage.opacity),
        colorBlendMode: BlendMode.modulate,
        gaplessPlayback: overlayImage.gaplessPlayback,
      ),
    );
  }
}
