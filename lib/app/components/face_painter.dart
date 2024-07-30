// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// class FacePainter extends CustomPainter {
  // final List<Face> faces;
  // final Size imageSize;

  // FacePainter(this.faces, this.imageSize);

  // @override
  // void paint(Canvas canvas, Size size) {
  //   final paint = Paint()
  //     ..color = Colors.red
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 2.0;

  //   for (Face face in faces) {
  //     final Rect boundingBox = face.boundingBox;

  //     final scaledRect = Rect.fromLTWH(
  //       boundingBox.left * size.width / imageSize.width,
  //       boundingBox.top * size.height / imageSize.height,
  //       boundingBox.width * size.width / imageSize.width,
  //       boundingBox.height * size.height / imageSize.height,
  //     );

  //     canvas.drawRect(scaledRect, paint);
  //   }
  // }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
