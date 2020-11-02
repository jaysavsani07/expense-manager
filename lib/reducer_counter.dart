import 'package:expense_manager/action_counter.dart';

int reducerCounter(int currentCount, action) {
  if (action is IncrementCountAction) {
    currentCount++;
    return currentCount;
  } else if (action is DecrementCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}
