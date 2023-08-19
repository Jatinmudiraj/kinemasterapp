import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindmaster/components/colors.dart';
import 'dart:math' as math;
import 'dart:io';
import 'package:helpers/helpers.dart'
    show OpacityTransition, SwipeTransition, AnimatedInteractiveViewer;
import 'package:image_picker/image_picker.dart';
import 'package:kindmaster/screens/CameraScreen.dart';
import 'package:kindmaster/screens/video_picker_screen.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';
import 'package:kindmaster/components/crop.dart';
import 'package:kindmaster/widgets/export_result.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key key, this.file}) : super(key: key);

  final File file;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  bool _exported = false;
  String _exportedText = "";
  VideoEditorController _controller;

  bool _isVisible = true;
  bool _isVisible2 = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
    _controller = VideoEditorController.file(widget.file,
        maxDuration: const Duration(seconds: 30))
      ..initialize().then((_) => setState(() {}));

    _controller
        .initialize(aspectRatio: 9 / 16)
        .then((_) => setState(() {}))
        .catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  void _openCropScreen() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => CropScreen(
                controller: _controller,
              )));

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;
    // NOTE: To use `-crf 1` and [VideoExportPreset] you need `ffmpeg_kit_flutter_min_gpl` package (with `ffmpeg_kit` only it won't work)
    await _controller.exportVideo(
      // preset: VideoExportPreset.medium,
      // customInstruction: "-crf 17",
      onProgress: (stats, value) => _exportingProgress.value = value,
      onError: (e, s) => _showErrorSnackBar("Error on export video :("),
      onCompleted: (file) {
        _isExporting.value = false;
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => VideoResultPopup(video: file),
        );
      },
    );
  }

  void _exportCover() async {
    await _controller.extractCover(
      onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
      onCompleted: (cover) {
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => CoverResultPopup(cover: cover),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: _controller.initialized
          ? SafeArea(
              child: Row(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 65,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, //back
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: () => _controller.rotate90Degrees(
                                  RotateDirection
                                      .right), //rotation towards right
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: () => _controller.rotate90Degrees(
                                  RotateDirection.left), //Rotation towards left
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: _openCropScreen, //crop
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: _exportCover, //export cover
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Container(
                            width: 55,
                            height: 55,
                            color: ShadowColor,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                  _isVisible2 = !_isVisible2;
                                });
                              },
                              child:
                                  Image(image: AssetImage('assets/back.png')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 14, 14, 14),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CropGridViewer.preview(
                                    controller: _controller,
                                  ),
                                  AnimatedBuilder(
                                    animation: _controller.video,
                                    builder: (_, __) => OpacityTransition(
                                      visible: !_controller.isPlaying,
                                      child: GestureDetector(
                                        onTap: _controller.video.play,

                                        



                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(children: [
                                Expanded(
                                    child: Container(
                                  // color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: bgcolor,
                                                title: const Center(
                                                    child: Text(
                                                  'Export Project',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                                content: Container(
                                                  // color: Colors.red,
                                                  height: 100,
                                                  child: Image(
                                                      image: AssetImage(
                                                          'assets/back.png')),
                                                ),
                                                actions: [
                                                  FloatingActionButton.extended(
                                                      backgroundColor: ButtonColor,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _exportVideo();
                                                      },
                                                      label:
                                                          Text('Export Video')),
                                                  FloatingActionButton.extended(
                                                      backgroundColor: ButtonColor,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _exportCover();
                                                      },
                                                      label:
                                                          Text('Export Thumbnail')),
                                                ],
                                              );
                                            });
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: ShadowColor,
                                          child: Image(
                                            image:
                                                AssetImage('assets/back.png'),
                                            width: 30,
                                            height: 30,
                                          )),
                                    ),
                                  ),
                                )),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      // color: Colors.green,
                                      child: _control(context),
                                    )),
                                Expanded(
                                    child: Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                                backgroundColor: ShadowColor,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/back.png'),
                                                  width: 30,
                                                  height: 30,
                                                )),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                                backgroundColor: ShadowColor,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/back.png'),
                                                  width: 30,
                                                  height: 30,
                                                )),
                                          ),
                                        ),
                                      ]),
                                )),
                              ]),
                            )),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _isVisible2,
                        child: _coverSelection(),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _trimSlider(),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _coverSelection() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: 100,
          // margin: EdgeInsets.symmetric(horizontal: height/2),
          child: SingleChildScrollView(
            child: CoverSelection(
              controller: _controller,
              size: height + 10,
              quantity: 30,
              selectedCoverBuilder: (cover, size) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    cover,
                    Icon(
                      Icons.check_circle,
                      color: const CoverSelectionStyle().selectedBorderColor,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _controller.video,
        ]),
        builder: (_, __) {
          final duration = _controller.videoDuration.inSeconds;
          final pos = _controller.trimPosition * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(
                formatter(Duration(seconds: pos.toInt())),
                style: TextStyle(color: Colors.white),
              ),
              const Expanded(child: SizedBox()),
              OpacityTransition(
                visible: _controller.isTrimming,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    formatter(_controller.startTrim),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    formatter(_controller.endTrim),
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ]),
          );
        },
      ),
      Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.symmetric(vertical: height / 8),
          child: TrimSlider(
            controller: _controller,
            height: height,
            horizontalMargin: height / 4,
            child: TrimTimeline(
              controller: _controller,
              padding: const EdgeInsets.only(top: 1),
            ),
          ),
        ),
      )
    ];
  }
}

Widget _control(BuildContext context) {
  return Container(
    width: 170,
    height: 170,
    child: Stack(
      children: <Widget>[
        Positioned(
          top: -4,
          left: 14,
          child: Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
                color: Color.fromARGB(57, 60, 74, 1),
                border: Border.all(
                  color: Color.fromRGBO(13, 14, 15, 1),
                  width: 4,
                ),
                borderRadius: BorderRadius.all(Radius.elliptical(200, 200))),
          ),
        ),
        Positioned(
          top: 39,
          left: 57,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 90, 92, 1),
              border: Border.all(
                color: Color.fromRGBO(13, 14, 15, 1),
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.elliptical(80, 80)),
            ),
          ),
        ),
        Positioned(
          top: 43,
          left: 32,
          child: Transform.rotate(
            angle: -42.95459263157254 * (math.pi / 180),
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 1),
              thickness: 1,
            ),
          ),
        ),
        Positioned(
          top: 135,
          left: 136,
          child: Transform.rotate(
            angle: -43.99491518079885 * (math.pi / 180),
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 1),
              thickness: 1,
            ),
          ),
        ),
        Positioned(
          top: 43,
          left: 165,
          child: Transform.rotate(
            angle: -137.04540736842748 * (math.pi / 180),
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 1),
              thickness: 1,
            ),
          ),
        ),
        Positioned(
          top: 135,
          left: 61,
          child: Transform.rotate(
            angle: -142.81529054453148 * (math.pi / 180),
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 1),
              thickness: 1,
            ),
          ),
        ),
        Positioned(
            top: 57,
            left: 73,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraScreen()));
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 05,
            left: 73,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoEditorExample()));
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 57,
            left: 120,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 57,
            left: 27,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
            top: 101,
            left: 73,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
          top: 126,
          left: 79,
          child: Text(
            'Rec',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        Positioned(
          top: 85,
          left: 126,
          child: Text(
            'Audio',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        Positioned(
          top: 85,
          left: 35,
          child: Text(
            'Layer',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        Positioned(
          top: 33,
          left: 76,
          child: Text(
            'MEDIA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
      ],
    ),
  );
  
}


//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
class VideoEditor extends StatefulWidget {
  const VideoEditor({key, this.file});

  final File file;

  @override
  State<VideoEditor> createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  bool _exported = false;
  String _exportedText = "";
  VideoEditorController _controller;

  //  final VideoEditorController _controller = VideoEditorController.file(
  //   widget.file,
  //   minDuration: const Duration(seconds: 1),
  //   maxDuration: const Duration(seconds: 10),
  // );

  @override
  void initState() {
    super.initState();

    _controller = VideoEditorController.file(widget.file,
        maxDuration: const Duration(seconds: 30))
      ..initialize().then((_) => setState(() {}));
    super.initState();

    _controller
        .initialize(aspectRatio: 9 / 16)
        .then((_) => setState(() {}))
        .catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;
    // NOTE: To use `-crf 1` and [VideoExportPreset] you need `ffmpeg_kit_flutter_min_gpl` package (with `ffmpeg_kit` only it won't work)
    await _controller.exportVideo(
      // preset: VideoExportPreset.medium,
      // customInstruction: "-crf 17",
      onProgress: (stats, value) => _exportingProgress.value = value,
      onError: (e, s) => _showErrorSnackBar("Error on export video :("),
      onCompleted: (file) {
        _isExporting.value = false;
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => VideoResultPopup(video: file),
        );
      },
    );
  }

  void _exportCover() async {
    await _controller.extractCover(
      onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
      onCompleted: (cover) {
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => CoverResultPopup(cover: cover),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _controller.initialized
            ? SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _topNavBar(),
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CropGridViewer.preview(
                                              controller: _controller),
                                          AnimatedBuilder(
                                            animation: _controller.video,
                                            builder: (_, __) =>
                                                OpacityTransition(
                                              visible: !_controller.isPlaying,
                                              child: GestureDetector(
                                                onTap: _controller.video.play,
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CoverViewer(controller: _controller)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      TabBar(
                                        tabs: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Icon(
                                                        Icons.content_cut)),
                                                Text('Trim')
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child:
                                                      Icon(Icons.video_label)),
                                              Text('Cover')
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: _trimSlider(),
                                            ),
                                            _coverSelection(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _isExporting,
                                  builder: (_, bool export, __) =>
                                      OpacityTransition(
                                    visible: export,
                                    child: AlertDialog(
                                      title: ValueListenableBuilder(
                                        valueListenable: _exportingProgress,
                                        builder: (_, double value, __) => Text(
                                          "Exporting video ${(value * 100).ceil()}%",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Leave editor',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.left),
                icon: const Icon(Icons.rotate_left),
                tooltip: 'Rotate unclockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.right),
                icon: const Icon(Icons.rotate_right),
                tooltip: 'Rotate clockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CropScreen(controller: _controller),
                  ),
                ),
                icon: const Icon(Icons.crop),
                tooltip: 'Open crop screen',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: PopupMenuButton(
                tooltip: 'Open export menu',
                icon: const Icon(Icons.save),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: _exportCover,
                    child: const Text('Export cover'),
                  ),
                  PopupMenuItem(
                    onTap: _exportVideo,
                    child: const Text('Export video'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _controller.video,
        ]),
        builder: (_, __) {
          final duration = _controller.videoDuration.inSeconds;
          final pos = _controller.trimPosition * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(formatter(Duration(seconds: pos.toInt()))),
              const Expanded(child: SizedBox()),
              OpacityTransition(
                visible: _controller.isTrimming,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(formatter(_controller.startTrim)),
                  const SizedBox(width: 10),
                  Text(formatter(_controller.endTrim)),
                ]),
              ),
            ]),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          controller: _controller,
          height: height,
          horizontalMargin: height / 4,
          child: TrimTimeline(
            controller: _controller,
            padding: const EdgeInsets.only(top: 10),
          ),
        ),
      )
    ];
  }

  Widget _coverSelection() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: CoverSelection(
            controller: _controller,
            size: height + 10,
            quantity: 8,
            selectedCoverBuilder: (cover, size) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  cover,
                  Icon(
                    Icons.check_circle,
                    color: const CoverSelectionStyle().selectedBorderColor,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
}
