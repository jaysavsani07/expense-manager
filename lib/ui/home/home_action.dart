import 'package:expense_manager/data/models/home_tab.dart';

class UpdateHomeTabAction {
  final HomeTab homeTab;

  UpdateHomeTabAction(this.homeTab);

  @override
  String toString() {
    return 'UpdateHomeTabAction{homeTab: $homeTab}';
  }
}
