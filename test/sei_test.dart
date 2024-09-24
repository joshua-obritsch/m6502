import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('SEI Implied', () {
    cpu.restart();

    memory[0x8000] = OpCode.seiImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.seiImplied,
      tcu: 2,
      p: 0x24,
      pc: 0x8001,
    );
  });
}
