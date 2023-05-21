import 'package:flutter/material.dart';

class KesandanPesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesan dan Pesan'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kesan:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Perkuliahan ini sangat bermanfaat dan memberikan pemahaman yang mendalam dalam bidang yang dipelajari. Materi yang diajarkan disampaikan dengan baik dan terstruktur',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Saran:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Saya ingin berterima kasih kepada dosen atas usaha dan dedikasinya dalam menyampaikan materi dengan jelas. Saya juga ingin mengingatkan untuk terus memberikan tantangan dan proyek praktis yang relevan dengan materi kuliah untuk memperkuat pemahaman',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
