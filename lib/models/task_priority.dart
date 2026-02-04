enum TaskPriority {
  low(1, 'Low'),
  medium(2, 'Medium'),
  high(3, 'High');

  final int value;
  final String label;

  const TaskPriority(this.value, this.label);
}
