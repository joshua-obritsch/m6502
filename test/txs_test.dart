import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('TXS Implied', () {
    cpu.restart();
    cpu.x = 0xA3;

    memory[0x8000] = OpCode.txsImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.txsImplied,
      tcu: 2,
      x: 0xA3,
      s: 0xA3,
      p: 0x20,
      pc: 0x8001,
    );
  });
}
