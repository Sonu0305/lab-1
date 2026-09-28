import 'package:web/web.dart' as web;
import 'dart:js_interop';

void main() {
  // 6. Use Dart DOM methods to access HTML elements
  final billInput = web.document.querySelector('#bill-amount') as web.HTMLInputElement;
  final tipInput = web.document.querySelector('#tip-percentage') as web.HTMLInputElement;
  final calculateBtn = web.document.querySelector('#calculate-btn') as web.HTMLButtonElement;
  final outputSection = web.document.querySelector('#output-section') as web.HTMLDivElement;
  final tipAmountDisplay = web.document.querySelector('#tip-amount') as web.HTMLSpanElement;
  final totalBillDisplay = web.document.querySelector('#total-bill') as web.HTMLSpanElement;

  // 7. Implement event handling for user interactions
  calculateBtn.addEventListener('click', ((web.Event event) {
    // 8. Read and process the values entered by the user
    final String billText = billInput.value;
    final String tipText = tipInput.value;

    final double bill = double.tryParse(billText) ?? 0.0;
    final double tipPercentage = double.tryParse(tipText) ?? 0.0;

    // 9. Perform the required operations using Dart
    final double tipAmount = bill * (tipPercentage / 100);
    final double totalBill = bill + tipAmount;

    // 10. Dynamically update the HTML content using DOM manipulation
    tipAmountDisplay.textContent = tipAmount.toStringAsFixed(2);
    totalBillDisplay.textContent = totalBill.toStringAsFixed(2);
    
    // Show the output section by removing the hidden class
    outputSection.classList.remove('hidden');
  }).toJS);
}
