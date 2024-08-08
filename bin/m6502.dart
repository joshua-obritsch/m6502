import 'package:m6502/cpu.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0] = 0xA9;
  memory[1] = 0xFF;
  memory[0xFFA9] = 0x33;

  print(cpu.memory.getInt8(0));
}
