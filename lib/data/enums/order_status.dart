import 'dart:ui';

enum OrderState {
  pending(1),
  InTheWarehouse(2),
  DeliveredToTheRepresentative(3),
  Delivered(4),
  Returning(5),
  ReturnInTheWarehouse(6),
  ClosedDelivered(7),
  DeliveredNdClosed(8);

  const OrderState(this.value);
  final int value;
}

extension OrderStateExtension on OrderState {
  String get orderStatusName {
    switch (this) {
      case OrderState.pending:
        return 'قيد الانتظار';
      case OrderState.InTheWarehouse:
        return 'في المخزن';
      case OrderState.DeliveredToTheRepresentative:
        return 'لدى للمندوب';
      case OrderState.Delivered:
        return 'تم التسليم';
      case OrderState.Returning:
        return 'قيد الاسترجاع';
      case OrderState.ReturnInTheWarehouse:
        return 'في المخزن';
      case OrderState. ClosedDelivered:
        return 'تم التسليم - مغلق';
      case OrderState.DeliveredNdClosed:
        return 'راجع - مغلق';
    }
  }

  Color get orderStatusColor {
    switch (this) {
      case OrderState.pending:
        return Color(0xff0438b6);
      case OrderState.InTheWarehouse:
        return Color(0xfff6c40b);
      case OrderState.DeliveredToTheRepresentative:
        return Color(0xffb00702);
      case OrderState.Delivered:
        return Color(0xff039460);
      case OrderState.Returning:
        return Color(0xff0438b6);
      case OrderState.ReturnInTheWarehouse:
        return Color(0xff6c0163);
      case OrderState.ClosedDelivered:
        return Color(0xffcb7c06);
      case OrderState.DeliveredNdClosed:
        return Color(0xff96014f);
    }
  }


}

extension OrderStateExtensionInt on int {
  OrderState get toOrderState {
    switch (this) {
      case 1:
        return OrderState.pending;
      case 2:
        return OrderState.InTheWarehouse;
      case 3:
        return OrderState.DeliveredToTheRepresentative;
      case 4:
        return OrderState.Delivered;
      case 5:
        return OrderState.Returning;
      case 6:
        return OrderState.ReturnInTheWarehouse;
      case 7:
        return OrderState.ClosedDelivered;
      case 8:
        return OrderState.DeliveredNdClosed;
      default:
        throw Exception('Invalid OrderState');
    }
  }
}
