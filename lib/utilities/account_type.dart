enum AccountType { customer, seller }

extension AccountTypeExtension on AccountType {
  String get apiValue {
    switch (this) {
      case AccountType.customer:
        return 'customer';
      case AccountType.seller:
        return 'seller';
    }
  }
}
