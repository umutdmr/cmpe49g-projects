  public class FlowField {
  PVector[][] vectors;
  float offset = 0;
  int cols, rows;
  int scale;
  
  FlowField(int res) {
    scale = res;
    cols = floor(width / res) + 1;
    rows = floor(height / res) + 1;
    vectors = new PVector[cols][rows];
  }
  
  void updateFF() {
    float x_offset = 0;
    for (int y = 0; y < rows; y++) { 
      float y_offset = 0;
      for (int x = 0; x < cols; x++) {
        float angle = noise(x_offset, y_offset, offset) * TWO_PI / 2;
        PVector v = PVector.fromAngle(angle);
        v.setMag(1);
        vectors[x][y] = v;
        x_offset += 0.1;
      }
      y_offset += 0.1;
    }
    offset += 0.000007;
  }

}
