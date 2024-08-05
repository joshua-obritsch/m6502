import 'package:app/cpu.dart';
import 'package:app/memory.dart';

void main() {
  final memory = Memory();
  final cpu = Cpu(memory: memory);

  memory[0] = 0xA9;
  memory[1] = 0xFF;
  memory[0xFFA9] = 0x33;

  print(cpu.memory.getInt8(0));
}
