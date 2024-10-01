import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('TSX Implied', () {
    cpu.restart();
    cpu.s = 0x3D;

    memory[0x8000] = OpCode.tsxImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.tsxImplied,
      tcu: 2,
      x: 0x3D,
      s: 0x3D,
      p: 0x20,
      pc: 0x8001,
    );
  });
}
