class Utils {
  // 计算椭圆路径点
  // double cx = 100; // 中心点 x 坐标
  // double cy = 50; // 中心点 y 坐标
  // double a = 100; // 长轴半径
  // double b = 50; // 短轴半径
  // double rotationAngle = -20; // 旋转角度，单位为度
  // int numberOfPoints = 360; // 点的数量
  static List<Offset> calculateRotatedEllipsePoints(double cx, double cy,
      double a, double b, double rotationAngle, int numberOfPoints) {
    List<Offset> points = [];

    double phi = rotationAngle * pi / 180.0;

    for (int i = 0; i < numberOfPoints; i++) {
      double theta = 2 * pi * i / numberOfPoints;
      double x = cx + a * cos(theta) * cos(phi) - b * sin(theta) * sin(phi);
      double y = cy + a * cos(theta) * sin(phi) + b * sin(theta) * cos(phi);
      points.add(Offset(x, y));
    }

    return points;
  }
}
