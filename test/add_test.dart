import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ADD Immediate', () {
    cpu.restart();

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 105;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      a: 105,
      pc: 0x8002,
    );
  });

  test('ADD Zero Page', () {
    cpu.restart();

    memory[0x0085] = 28;
    memory[0x8000] = OpCode.adcZeroPage;
    memory[0x8001] = 0x85;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPage,
      a: 28,
      pc: 0x8002,
    );
  });

  test('ADD Zero Page X', () {
    cpu.restart();
    cpu.x = 0x46;

    memory[0x006E] = 159;
    memory[0x8000] = OpCode.adcZeroPageX;
    memory[0x8001] = 0x28;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPageX,
      a: 159,
      x: 0x46,
      p: 0x80,
      pc: 0x8002,
    );
  });

  test('ADD Absolute', () {
    cpu.restart();

    memory[0x6A9F] = 13;
    memory[0x8000] = OpCode.adcAbsolute;
    memory[0x8001] = 0x9F;
    memory[0x8002] = 0x6A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsolute,
      a: 13,
      pc: 0x8003,
    );
  });

  test('ADD Absolute X', () {
    cpu.restart();
    cpu.x = 0x74;

    memory[0x53F6] = 109;
    memory[0x8000] = OpCode.adcAbsoluteX;
    memory[0x8001] = 0x82;
    memory[0x8002] = 0x53;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsoluteX,
      a: 109,
      x: 0x74,
      pc: 0x8003,
    );
  });
}
