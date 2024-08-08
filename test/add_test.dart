import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  test('ADD Immediate', () {
    memory[0] = OpCode.adcImmediate;
    memory[1] = 5;

    cpu.fetch();
    cpu.execute();

    expect(cpu.a, 5);
  });
}
