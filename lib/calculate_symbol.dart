

enum CalculateSymbol{
  Add,Sub,Div,Multiplied,Clear,AllClear,Setting,Equal
}
extension CalculateSymbolExtension on CalculateSymbol{
  bool isCalculate(){
    switch(this){
      case CalculateSymbol.Add:
      case CalculateSymbol.Sub:
      case CalculateSymbol.Div:
      case CalculateSymbol.Multiplied:
      case CalculateSymbol.Equal:
        return true;
      default:
        return false;
    }
  }
  String getName(){
    switch(this) {
      case CalculateSymbol.Add:
        return '+';
      case CalculateSymbol.Sub:
        return '-';
      case CalculateSymbol.Div:
        return '÷';
      case CalculateSymbol.Multiplied:
        return '×';
      case CalculateSymbol.Clear:
        return 'C';
      case CalculateSymbol.AllClear:
        return 'AC';
      case CalculateSymbol.Setting:
        return 'S';
      case CalculateSymbol.Equal:
        return '=';
    }
  }
}