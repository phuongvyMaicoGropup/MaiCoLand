import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'land_planning_details_information.dart';

class LandPlanningDetailMapScreen extends StatefulWidget {
  final LandPlanning landPlanning;
  const LandPlanningDetailMapScreen(
      {required this.controller, required this.landPlanning});

  final Completer<WebViewController> controller;

  @override
  _LandPlanningDetailMapScreenState createState() =>
      _LandPlanningDetailMapScreenState();
}

class _LandPlanningDetailMapScreenState
    extends State<LandPlanningDetailMapScreen> {
  static Future<String> _prepareLocalFile(String htmlString) async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File('$tmpDir/www/index.html');

    await Directory('$tmpDir/www').create(recursive: true);
    await indexFile.writeAsString(htmlString);

    return indexFile.path;
  }

  Future<void> _onLoadHtmlStringExample(
      WebViewController controller, BuildContext context) async {
    String file = '''
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />

    <title>Add a raster image to a map layer</title>
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.css" rel="stylesheet" />
    <script src="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
        }
        
        #map {
            position: absolute;
            top: 0;
            bottom: 0;
            width: 100%;
            object-fit: cover;
        }
        
        #map>img {
            transform: scale(1.6);
        }
        
        .map-overlay {
            font: 12px/20px 'Helvetica Neue', Arial, Helvetica, sans-serif;
            position: absolute;
            width: 75%;
            bottom: 0;
            right: 0;
            padding: 10px;
        }
        
        .map-overlay input {
            background-color: transparent;
            display: inline-block;
            width: 100%;
            position: relative;
            margin: 0;
            cursor: ew-resize;
        }
        
        #menu {
            position: absolute;
            padding: 10px;
            right: 0;
            top: 0;
        }
        
        input {
            display: none;
        }
        
        label {
            cursor: pointer;
            margin: 4px 4px;
        }
        
        label:before {
            content: '';
            display: inline-block;
            height: 15px;
            width: 15px;
            background: #59CA59;
            border-radius: 50%;
            z-index: 2;
            transition: box-shadow .4s ease, background .3s ease;
        }
        
        input:checked+label:before {
            box-shadow: inset 0px 1px 0 1px rgba(89, 202, 89, 1);
            background: #fff;
        }
    </style>
</head>

<body>
    <style>
        .calculation-box {
            height: 75px;
            width: 150px;
            position: absolute;
            bottom: 40px;
            left: 10px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 15px;
            text-align: center;
        }
        
        p {
            font-family: 'Open Sans';
            margin: 0;
            font-size: 13px;
        }
    </style>
    <script src="https://unpkg.com/@turf/turf@6/turf.min.js"></script>
    <script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.2.2/mapbox-gl-draw.js"></script>
    <link rel="stylesheet" href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.2.2/mapbox-gl-draw.css" type="text/css">
    <div id="map"></div>
    <div class="calculation-box">
        <p>Ấn vào để chọn điểm </p>
        <div id="calculated-area"></div>
    </div>
    <div class="map-overlay top">
        <input id="slider" type="range" min="0" max="100" value="100">
    </div>
    <div id="menu">
        <input id="satellite-v9" type="radio" name="rtoggle" value="satellite" checked="checked">
        <!-- See a list of Mapbox-hosted public styles at -->
        <!-- https://docs.mapbox.com/api/maps/styles/#mapbox-styles -->
        <input id="outdoors-v11" type="radio" name="rtoggle" value="outdoors">
        <label for="outdoors-v11"></label>
        <label for="satellite-v9"></label>
        <input id="light-v10" type="radio" name="rtoggle" value="light">
        <label for="light-v10"></label>
        <input id="dark-v10" type="radio" name="rtoggle" value="dark">
        <label for="dark-v10"></label>
        <input id="streets-v11" type="radio" name="rtoggle" value="streets">
        <label for="streets-v11"></label>

    </div>
    <script>
        // TO MAKE THE MAP APPEAR YOU MUST
        // ADD YOUR ACCESS TOKEN FROM
        // https://account.mapbox.com

        mapboxgl.accessToken =
            'pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ'

        var map = new mapboxgl.Map({
                container: 'map',
                zoom: 9,
                center:[${widget.landPlanning.rightBottom.longitude}, ${widget.landPlanning.rightBottom.latitude}],

                // style: 'mapbox://styles/andreatran2002/ckxuiyic394hv16ryg9jx3jb7',
                style: 'mapbox://styles/mapbox/outdoors-v11'
            })
            // disable map rotation using right click + drag
        map.dragRotate.disable()
        const slider = document.getElementById('slider');
        // disable map rotation using touch rotation 7
        map.touchZoomRotate.disableRotation()
        const layerList = document.getElementById('menu');
        const inputs = layerList.getElementsByTagName('input');

        map.on('load', () => {
            addMaineLayer();

            slider.addEventListener('input', (e) => {
                // Adjust the layers opacity. layer here is arbitrary - this could
                // be another layer name found in your style or a custom layer
                // added on the fly using `addSource`.
                map.setPaintProperty(
                    'map-layer',
                    'raster-opacity',
                    parseInt(e.target.value, 10) / 100
                );
                map.setPaintProperty(
                    'map-layer-update',
                    'raster-opacity',
                    parseInt(e.target.value, 10) / 100
                );

            });

            function switchLayer(layer) {
                // addMaineLayer fn will be called once on layer switched
                map.once("styledata", addMaineLayer);
                const layerId = layer.target.id;
                map.setStyle("mapbox://styles/mapbox/" + layerId);
                slider.value = 100

            }

            // set toggle base style events
            for (let i = 0; i < inputs.length; i++) {
                inputs[i].onclick = switchLayer;
            }
        });

        function addLayerBefore(addLayerFn, layer, beforeId) {
            // check beforeId defined and exists on the map
            const beforeLayer = Boolean(beforeId) && map.getLayer(beforeId);
            if (beforeLayer && beforeId === beforeLayer.id) addLayerFn(layer, beforeId);
            else {
                console.warn(
                    `Not found layer with id '\${beforeId}'.\nLayer '\${layer.id}' added without before.`
                );
                addLayerFn(layer);
            }
        }

        function addMaineLayer() {

            map.addSource('map', {
				type: 'image',
					url: '${widget.landPlanning.imageUrl}',
					coordinates: [
						[${widget.landPlanning.leftTop.longitude}, ${widget.landPlanning.leftTop.latitude}],
						[${widget.landPlanning.rightTop.longitude}, ${widget.landPlanning.rightTop.latitude}],
						[${widget.landPlanning.rightBottom.longitude}, ${widget.landPlanning.rightBottom.latitude}],
						[${widget.landPlanning.leftBottom.longitude}, ${widget.landPlanning.leftBottom.latitude}],
					],
			})
                // map.addLayer({
                // 	id: 'map-layer',
                // 	type: 'raster',
                // 	source: 'map',
                // })

            // define the function to add layer
            const addLayer = (layer, beforeId) => map.addLayer(layer, beforeId);

            addLayerBefore(
                addLayer, {
                    id: "map-layer-update",
                    type: "raster",
                    source: "map",
                }, "map-layer"
            );
            const draw = new MapboxDraw({
                displayControlsDefault: false,
                // Select which mapbox-gl-draw control buttons to add to the map.
                controls: {
                    polygon: true,
                    trash: true
                },
                // Set mapbox-gl-draw to draw by default.
                // The user does not have to click the polygon control button first.
                defaultMode: 'draw_polygon'
            });
            map.addControl(draw);

            map.on('draw.create', updateArea);
            map.on('draw.delete', updateArea);
            map.on('draw.update', updateArea);

            function updateArea(e) {
                const data = draw.getAll();
                const answer = document.getElementById('calculated-area');
                if (data.features.length > 0) {
                    const area = turf.area(data);
                    // Restrict the area to 2 decimal points.
                    const rounded_area = Math.round(area * 100) / 100;
                    answer.innerHTML = `<p>Diện tích : <strong>\${rounded_area}</strong> m²</p>`;
                } else {
                    answer.innerHTML = '';
                    if (e.type !== 'draw.delete')
                        alert('Click the map to draw a polygon.');
                }
            }
        }
        const cors = require('cors')({
            origin: true
        });
    </script>
</body>

</html>
''';

    await controller.loadHtmlString(file);
  }

  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MaicoLand"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandPlanningDetailInfoScreen(
                            landPlanning: widget.landPlanning,
                          )));
            },
            icon: const Icon(
              Icons.article,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'about:blank',
            onWebViewCreated: (webViewController) async {
              // widget.controller.complete(webViewController);
              await _onLoadHtmlStringExample(webViewController, context);
              //         await _loadHtmlFromAssets();
              widget.controller.complete(webViewController);
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            // Add from here ...
            navigationDelegate: (navigation) {
              final host = Uri.parse(navigation.url).host;
              if (host.contains('youtube.com')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Blocking navigation to $host',
                    ),
                  ),
                );
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            // ... to here.
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
         
        ],
      ),

      // Builder(builder: (BuildContext context) {
      //   return Stack(children: [
      //     WebView(
      //       key: UniqueKey(),
      //       initialUrl: 'about:blank',
      //       javascriptMode: JavascriptMode.unrestricted,
      //       onWebViewCreated: (WebViewController webViewController) async {
      //         _controller = webViewController;
      //         await _loadHtmlFromAssets();
      //       },
      //     ),
      //     // Positioned(
      //     //   right: 5,
      //     //   top: MediaQuery.of(context).size.height * 0.2,
      //     //   child: Container(
      //     //       padding: const EdgeInsets.all(5),
      //     //       decoration: BoxDecoration(
      //     //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //     //           color: AppColors.black.withOpacity(0.4)),
      //     //       child: Column(
      //     //         children: [
      //     //           GestureDetector(
      //     //             onTap: () {},
      //     //             child: Icon(EvaIcons.heart,
      //     //                 color: AppColors.black.withOpacity(0.5)),
      //     //           ),
      //     //           SizedBox(height: 4),
      //     //           Icon(Icons.cancel,
      //     //               color: AppColors.black.withOpacity(0.5)),
      //     //           SizedBox(height: 4),
      //     //           Icon(EvaIcons.compass,
      //     //               color: AppColors.black.withOpacity(0.5)),
      //     //           SizedBox(height: 4),
      //     //         ],
      //     //       )),
      //     // )
      //   ]);
      // })
    );
  }

  _loadHtmlFromAssets() async {
    // _controller.getSettings().setDomStorageEnabled(true);

    // controller.loadUrl(Uri.dataFromString(fileText,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString());
    // _controller.loadUrl(
    //     "https://www.google.com/maps/d/viewer?mid=1lJ7IdqA60d1IdcpuQAWqrNzFtr_qyLyr&ll=10.046498573785454%2C104.01220708579629&z=15");
  }
}
