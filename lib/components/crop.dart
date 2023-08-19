import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:kindmaster/components/colors.dart';
import 'package:video_editor/video_editor.dart';

class CropScreen extends StatelessWidget {
  const CropScreen({key, this.controller});

  final VideoEditorController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShadowColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(children: [
            Row(children: [
              Expanded(
                child: IconButton(
                  onPressed: () =>
                      controller.rotate90Degrees(RotateDirection.left),
                  icon: const Icon(Icons.rotate_left,color: Colors.white,),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () =>
                      controller.rotate90Degrees(RotateDirection.right,),
                  icon: const Icon(Icons.rotate_right,color: Colors.white,),
                ),
              )
            ]),
            const SizedBox(height: 15),
            Expanded(
              child: CropGridViewer.edit(
                controller: controller,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            const SizedBox(height: 15),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                // flex: 2,
                    child: FloatingActionButton.extended(
                      backgroundColor: ButtonColor,
                      onPressed: () =>  Navigator.pop(context),
                      label: const Text(
                        "cancel",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  
              ),
              Expanded(
                flex: 4,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () =>
                                controller.preferredCropAspectRatio = controller
                                    .preferredCropAspectRatio
                                    ?.toFraction()
                                    .inverse()
                                    .toDouble(),
                            icon: controller.preferredCropAspectRatio != null &&
                                    controller.preferredCropAspectRatio < 1 //in this line preferredCropAspectRatio! < 1 ----- ! is removed.
                                ? const Icon(
                                    Icons.panorama_vertical_select_rounded)
                                : const Icon(Icons.panorama_vertical_rounded),
                          ),
                          IconButton(
                            onPressed: () =>
                                controller.preferredCropAspectRatio = controller
                                    .preferredCropAspectRatio
                                    ?.toFraction()
                                    .inverse()
                                    .toDouble(),
                            icon: controller.preferredCropAspectRatio != null &&
                                    controller.preferredCropAspectRatio > 1 //in this line preferredCropAspectRatio! < 1 ----- ! is removed.
                                ? const Icon(
                                    Icons.panorama_horizontal_select_rounded)
                                : const Icon(Icons.panorama_horizontal_rounded),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildCropButton(context, null),
                          _buildCropButton(context, 1.toFraction()),
                          _buildCropButton(
                              context, Fraction.fromString("9/16")),
                          _buildCropButton(context, Fraction.fromString("3/4")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                // flex: 2,
                child: FloatingActionButton.extended(
                      backgroundColor: ButtonColor,
                      onPressed: () {
                    
                    controller.updateCrop();
                    Navigator.pop(context);
                  },
                      label: const Text(
                        "Done",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _buildCropButton(BuildContext context, Fraction f) {
    if (controller.preferredCropAspectRatio != null &&
        controller.preferredCropAspectRatio > 1) f = f?.inverse();  //in this line preferredCropAspectRatio! < 1 ----- ! is removed.

    return Flexible(
      child: TextButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: controller.preferredCropAspectRatio == f?.toDouble()
              ? Colors.grey.shade800
              : null,
          foregroundColor: controller.preferredCropAspectRatio == f?.toDouble()
              ? Colors.white
              : null,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: () => controller.preferredCropAspectRatio = f?.toDouble(),
        child: Text(f == null ? 'free' : '${f.numerator}:${f.denominator}'),
      ),
    );
  }
}