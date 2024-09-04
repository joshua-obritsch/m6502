import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('INX Implied', () {
    cpu.restart();
    cpu.x = 151;

    memory[0x8000] = OpCode.inxImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.inxImplied,
      tcu: 2,
      x: 152,
      p: 0xA0,
      pc: 0x8001,
    );
  });
}
