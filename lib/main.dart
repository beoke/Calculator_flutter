// Mengimpor paket-paket yang dibutuhkan
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

// Fungsi utama aplikasi, yang menjalankan aplikasi MyApp
void main() => runApp(const MyApp());

// Widget utama aplikasi yang merupakan StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Scaffold menyediakan struktur dasar untuk halaman aplikasi
      home: Scaffold(
        appBar: AppBar(
          // Judul aplikasi di dalam AppBar
          title: const Text('Simple Calculator'),
        ),
        // Padding untuk memberikan jarak di sekeliling widget di dalamnya
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: SizedBox(
            // Mengatur lebar widget agar memenuhi lebar layar
            width: double.infinity,
            // Menampilkan widget CalcButton sebagai konten utama
            child: CalcButton(),
          ),
        ),
      ),
    );
  }
}

// Widget CalcButton yang merupakan StatefulWidget
class CalcButton extends StatefulWidget {
  const CalcButton({Key? key}) : super(key: key);

  @override
  CalcButtonState createState() => CalcButtonState();
}

// State dari CalcButton yang menyimpan nilai dan menangani perubahan
class CalcButtonState extends State<CalcButton> {
  // Variabel untuk menyimpan nilai saat ini yang ditampilkan di kalkulator
  double? _curentValue = 0;

  @override
  Widget build(BuildContext context) {
    // Membuat instance dari SimpleCalculator dengan konfigurasi yang ditentukan
    var calc = SimpleCalculator(
      value: _curentValue!, // Nilai awal kalkulator
      hideExpression: false, // Menampilkan ekspresi perhitungan
      hideSurroundingBorder: true, // Menghilangkan border di sekitar kalkulator
      autofocus: true, // Fokus otomatis pada kalkulator saat muncul
      onChanged: (key, value, expression) {
        // Callback ketika nilai kalkulator berubah
        setState(() {
          _curentValue = value ?? 0; // Mengupdate nilai saat ini
        });
        if (kDebugMode) {
          // Mencetak informasi ke konsol jika dalam mode debug
          print('$key \$value\t$expression');
        }
      },
      onTappedDisplay: (value, details) {
        // Callback ketika tampilan kalkulator diketuk
        if (kDebugMode) {
          // Mencetak nilai dan posisi ketukan ke konsol
          print('$value\t${details.globalPosition}');
        }
      },
      theme: const CalculatorThemeData(
        // Menentukan tema tampilan kalkulator
        borderColor: Colors.black, // Warna border
        borderWidth: 2, // Lebar border
        displayColor: Colors.white, // Warna latar tampilan
        expressionColor: Colors.indigo, // Warna ekspresi perhitungan
        expressionStyle: TextStyle(fontSize: 80, color: Colors.yellow), // Gaya teks ekspresi
        operatorColor: Colors.pink, // Warna operator (+, -, dll)
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white), // Gaya teks operator
        commandColor: Colors.orange, // Warna tombol perintah (C, AC, dll)
        commandStyle: TextStyle(fontSize: 30, color: Colors.white), // Gaya teks perintah
        numColor: Colors.grey, // Warna tombol angka
        numStyle: TextStyle(fontSize: 50, color: Colors.white), // Gaya teks angka
      ),
    );

    // Mengembalikan OutlinedButton yang menampilkan nilai saat ini
    return OutlinedButton(
      child: Text(_curentValue.toString()), // Teks pada tombol adalah nilai saat ini
      onPressed: () {
        // Ketika tombol ditekan, menampilkan ModalBottomSheet dengan kalkulator
        showModalBottomSheet(
          isScrollControlled: true, // Mengizinkan layar untuk di-scroll saat keyboard muncul
          context: context,
          builder: (BuildContext context) {
            // Mengatur tinggi kalkulator menjadi 75% dari tinggi layar
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: calc, // Menampilkan kalkulator
            );
          },
        );
      },
    );
  }

  // Menambahkan getter untuk mengakses widget CalcButton
  CalcButton get widget => super.widget;
}
