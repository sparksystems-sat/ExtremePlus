abstract class StudentEvent {
   const StudentEvent();
} 


class StudentNameevent extends StudentEvent {
  final String name;
  const StudentNameevent(this.name);
}