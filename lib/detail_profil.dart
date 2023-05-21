import 'package:flutter/material.dart';

class DetailProfilPage extends StatefulWidget {
  @override
  _DetailProfilPageState createState() => _DetailProfilPageState();
}

class _DetailProfilPageState extends State<DetailProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),

      body: Container(
        color: Colors.white, // Menggunakan warna latar belakang tunggal
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('images/profile1.jpg'),
                radius: 50,
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text('NIM : 123200027'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Nama : Gilang Pappa Tanto Pambua'),
              ),
              ListTile(
                leading: Icon(Icons.class__rounded),
                title: Text('Kelas : Teknologi Dan Pemrograman Mobile IF-B'),
              ),
              ListTile(
                leading: Icon(Icons.cake),
                title: Text(
                    'Tempat, Tanggal Lahir : Rantepao, 8 September 2002'),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                    'Harapan / Cita-cita : Menjadi Network Security Engineer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}