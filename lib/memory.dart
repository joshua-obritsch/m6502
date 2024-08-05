import 'dart:typed_data';

class Memory {
  /// Represents the data in memory.
  final ByteData _data;

  Memory() : _data = ByteData(65536);

  /// Gets the unsigned 8-bit integer located at the given memory position.
  int operator [](int offset) => _data.getUint8(offset);

  /// Sets the unsigned 8-bit integer located at the given memory position.
  void operator []=(int offset, int value) => _data.setUint8(offset, value);

  /// Gets the signed 8-bit integer located at the given memory position.
  int getInt8(int offset) => _data.getInt8(offset);

  /// Gets the unsigned 16-bit integer located at the given memory position.
  int getUint16(int offset) => _data.getUint16(offset, Endian.little);

  /// Clears all the data in memory.
  void clear() {
    for (var i = 0; i < _data.lengthInBytes; i++) {
      _data.setUint8(i, 0);
    }
  }
}
