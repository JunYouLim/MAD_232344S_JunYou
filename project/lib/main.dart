import 'package:flutter/material.dart';
import 'Profile.dart';
import 'About.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}

class MainTabController extends StatefulWidget {
  final String userName;
  final String userEmail;

  MainTabController({required this.userName, required this.userEmail});

  @override
  _MainTabControllerState createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(userName: widget.userName, userEmail: widget.userEmail),
      Profile(userName: widget.userName, userEmail: widget.userEmail),  // Modified to use updated Profile page
      About(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;
  final String userEmail;


  HomePage({required this.userName, required this.userEmail});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedSpecialization;
  List<Map<String, String>> filteredClinics = [];
  String searchQuery = '';
  
  final List<Map<String, String>> clinics = [
    {
    'name': 'Raffles Medical (Raffles Place)',
    'location': 'Raffles Place, 1 Raffles Link, #B1-20, Singapore 039393',
    'specialization': 'General Medicine, Health Screening',
    'hotline': '+65 6311 1288',
    'distance': 'Approx. 5 minutes walk from Raffles MRT',
    'description': 'Raffles Medical at Raffles Place is a comprehensive healthcare provider offering general medical consultations, vaccinations, and health screenings. The clinic is conveniently located in the central business district, catering to both individual and corporate health needs, providing efficient and quality care with a focus on convenience for busy professionals.'
  },
  {
    'name': 'Singapore General Hospital (SGH)',
    'location': 'Outram Road, Singapore 169608',
    'specialization': 'Emergency, Surgery, Cardiology',
    'hotline': '+65 6222 3322',
    'distance': 'Approx. 10 minutes walk from Outram Park MRT',
    'description': 'As Singapore\'s oldest and largest hospital, SGH is a leading healthcare institution offering a broad range of medical services. SGH specializes in complex cases, emergency care, surgery, cardiology, neurology, and more. It is a teaching hospital and is recognized for its excellence in clinical services and cutting-edge research.'
  },
  {
    'name': 'Novena Medical Center',
    'location': '10 Sinaran Drive, #10-01, Singapore 307506',
    'specialization': 'Oncology, Orthopedics, Pediatrics',
    'hotline': '+65 6251 4455',
    'distance': 'Approx. 5 minutes walk from Novena MRT',
    'description': 'Novena Medical Center offers a wide array of specialized services in fields like oncology, pediatrics, orthopedics, and cardiology. With its focus on advanced healthcare and patient-centric care, it caters to both local and international patients. The center provides a comfortable environment with easy access from the Novena MRT.'
  },
  {
    'name': 'Mount Elizabeth Hospital',
    'location': '3 Mount Elizabeth, Singapore 228510',
    'specialization': 'Obstetrics & Gynecology, Cardiothoracic Surgery',
    'hotline': '+65 6737 2666',
    'distance': 'Approx. 8 minutes walk from Orchard MRT',
    'description': 'Mount Elizabeth is a premier private hospital in Singapore, known for its high-quality healthcare and specialties in cardiothoracic surgery, obstetrics and gynecology, fertility treatments, and oncology. It offers personalized care and has advanced medical technology, providing services for both local and international patients.'
  },
  {
    'name': 'Healthway Medical',
    'location': '86 Bedok North Street 4, #01-186, Singapore 460086',
    'specialization': 'General Medicine, Vaccinations, Health Screening',
    'hotline': '+65 6444 9488',
    'distance': 'Approx. 7 minutes walk from Bedok MRT',
    'description': 'Healthway Medical provides accessible and affordable healthcare services with a network of clinics across Singapore. They offer general medical care, health screenings, vaccination services, and chronic disease management. The clinic emphasizes preventive care and overall well-being for individuals and families.'
  },
  {
    'name': 'Tan Tock Seng Hospital',
    'location': '11 Jalan Tan Tock Seng, Singapore 308433',
    'specialization': 'General Medicine, Neurology, Renal Medicine',
    'hotline': '+65 6256 6011',
    'distance': 'Approx. 5 minutes walk from Novena MRT',
    'description': 'One of Singapore’s most well-established hospitals, Tan Tock Seng Hospital offers a wide range of specialized services, including emergency medicine, general surgery, cardiology, and neurology. It is also home to the National Centre for Infectious Diseases (NCID) and is known for its extensive clinical research and patient care.'
  },
  {
    'name': 'Changi General Hospital',
    'location': '2 Simei Street 3, Singapore 529889',
    'specialization': 'Cardiology, Orthopedics, Obstetrics',
    'hotline': '+65 6788 8833',
    'distance': 'Approx. 10 minutes walk from Simei MRT',
    'description': 'Changi General Hospital serves the eastern region of Singapore, providing comprehensive medical services from general medicine to surgery, cardiology, and orthopedics. The hospital is known for its strong focus on patient care and community health, offering specialized services in women’s health, geriatric care, and rehabilitation.'
  },
  {
    'name': 'Tiong Bahru Clinic',
    'location': '36 Eng Hoon Street, #01-01, Singapore 160036',
    'specialization': 'General Medicine, Family Health',
    'hotline': '+65 6270 6313',
    'distance': 'Approx. 5 minutes walk from Tiong Bahru MRT',
    'description': 'Tiong Bahru Clinic is a family-friendly clinic offering general healthcare services, including chronic disease management, health screenings, and vaccinations. It is located in the historical Tiong Bahru neighborhood, providing a welcoming and personalized healthcare experience for individuals and families in the area.'
  },
  {
    'name': 'National Skin Centre',
    'location': '1 Mandalay Road, Singapore 308205',
    'specialization': 'Dermatology, Skin Conditions',
    'hotline': '+65 6350 8888',
    'distance': 'Approx. 10 minutes walk from Novena MRT',
    'description': 'The National Skin Centre is a leading dermatological institution in Singapore, specializing in the treatment of skin conditions such as acne, eczema, psoriasis, and skin cancer. The center provides advanced dermatology services, including medical treatments, laser therapies, and cosmetic dermatology, using state-of-the-art technology.'
  },
  {
    'name': 'Mount Alvernia Hospital',
    'location': '820 Thomson Road, Singapore 574623',
    'specialization': 'Obstetrics & Gynecology, Pediatrics, Surgery',
    'hotline': '+65 6347 6688',
    'distance': 'Approx. 8 minutes walk from Marymount MRT',
    'description': 'Mount Alvernia Hospital is a private hospital known for its specialized care in obstetrics, gynecology, pediatrics, and general surgery. It offers compassionate and high-quality healthcare with a focus on family-centered services, providing a range of medical treatments in a comfortable environment.'
  },
  {
    'name': 'Khoo Teck Puat Hospital',
    'location': '90 Yishun Central, Singapore 768828',
    'specialization': 'Cardiology, Surgery, General Medicine',
    'hotline': '+65 6555 8000',
    'distance': 'Approx. 10 minutes walk from Khatib MRT',
    'description': 'Khoo Teck Puat Hospital is a modern hospital located in the northern region of Singapore, offering comprehensive medical services in cardiology, surgery, and general medicine. It is well-known for its patient-centered care and advanced medical facilities, serving the healthcare needs of the Yishun community.'
  },
  {
    'name': 'Thomson Medical Centre',
    'location': '339 Thomson Road, Singapore 307677',
    'specialization': 'Obstetrics & Gynecology, Pediatrics',
    'hotline': '+65 6256 9888',
    'distance': 'Approx. 5 minutes walk from Novena MRT',
    'description': 'Thomson Medical Centre is renowned for its expertise in obstetrics, gynecology, and pediatrics. It provides a full range of maternity and child care services, with a focus on personalized care and comfort. The center’s commitment to excellence in women’s and children’s health has made it a trusted institution.'
  },
  {
    'name': 'Raffles Medical (Changi Airport)',
    'location': 'Changi Airport Terminal 3, Singapore 819663',
    'specialization': 'General Medicine, Health Screening, Travel Medicine',
    'hotline': '+65 6241 6011',
    'distance': 'Approx. 10 minutes walk from Changi Airport MRT',
    'description': 'Raffles Medical at Changi Airport provides comprehensive healthcare services tailored for travelers, including health screenings, general medical care, and travel-related health consultations. It is conveniently located in one of the busiest airports in the world, offering convenient medical services for both local and international visitors.'
  },
  {
    'name': 'Boon Keng Clinic',
    'location': '3 Boon Keng Road, #01-02, Singapore 330003',
    'specialization': 'General Medicine, Health Screening',
    'hotline': '+65 6296 3878',
    'distance': 'Approx. 5 minutes walk from Boon Keng MRT',
    'description': 'Boon Keng Clinic offers a variety of healthcare services, including general medical consultations, health screenings, and preventive care. It is conveniently located near Boon Keng MRT, providing accessible healthcare services to the surrounding community.'
  },
  {
    'name': 'Sengkang General Hospital',
    'location': '110 Sengkang East Way, Singapore 544886',
    'specialization': 'Emergency, Pediatrics, Cardiology',
    'hotline': '+65 6930 6900',
    'distance': 'Approx. 5 minutes walk from Sengkang MRT',
    'description': 'Sengkang General Hospital is a modern hospital serving the northeastern region of Singapore, offering a range of services, including emergency care, pediatrics, and cardiology. The hospital is equipped with the latest medical technology, providing high-quality care for its patients.'
  },
  {
    'name': 'Yishun Polyclinic',
    'location': '5 Yishun Central 2, Singapore 768023',
    'specialization': 'General Medicine, Pediatrics, Family Health',
    'hotline': '+65 6807 7360',
    'distance': 'Approx. 8 minutes walk from Yishun MRT',
    'description': 'Yishun Polyclinic is a community healthcare facility providing general medical services, pediatric care, and family health services. It offers affordable care and is committed to promoting the well-being of the Yishun community with a focus on preventive healthcare and chronic disease management.'
  },
  {
    'name': 'East Shore Hospital (Parkway East Hospital)',
    'location': '321 Joo Chiat Place, Singapore 427990',
    'specialization': 'Surgery, Cardiology, General Medicine',
    'hotline': '+65 6348 3666',
    'distance': 'Approx. 7 minutes walk from Eunos MRT',
    'description': 'East Shore Hospital, now known as Parkway East Hospital, offers specialized services in surgery, cardiology, and general medicine. Located in the heart of Joo Chiat, the hospital is known for its comfortable environment and quality care, with a focus on personalized treatment for its patients.'
  },
  {
    'name': 'Gleneagles Hospital',
    'location': '6A Napier Road, Singapore 258500',
    'specialization': 'Cardiology, Orthopedic Surgery, Women\'s Health',
    'hotline': '+65 6473 7222',
    'distance': 'Approx. 7 minutes walk from Napier MRT',
    'description': 'Gleneagles Hospital is a renowned private hospital offering specialized services in cardiology, orthopedic surgery, and women’s health. The hospital is equipped with state-of-the-art medical facilities and offers world-class healthcare with a focus on personalized care and a holistic approach to healing.'
  },
  {
    'name': 'Chinatown Point Medical Centre',
    'location': '133 New Bridge Road, #08-06, Singapore 059413',
    'specialization': 'General Medicine, Health Screening',
    'hotline': '+65 6533 7788',
    'distance': 'Approx. 5 minutes walk from Chinatown MRT',
    'description': 'Chinatown Point Medical Centre provides general medical services, including health screenings, vaccinations, and chronic disease management. The clinic is easily accessible in the Chinatown area and caters to individuals looking for quality healthcare services in a convenient and central location.'
  },
    // Add all other clinics here...
  ];

 @override
  void initState() {
    super.initState();
    filteredClinics = List.from(clinics); // Initialize with all clinics
  }

  void filterClinics(String searchText, String? specialization) {
    setState(() {
      filteredClinics = clinics.where((clinic) {
        // Filter by search text
        bool matchesSearch = clinic['name']!.toLowerCase().contains(searchText.toLowerCase()) ||
            clinic['location']!.toLowerCase().contains(searchText.toLowerCase()) ||
            clinic['specialization']!.toLowerCase().contains(searchText.toLowerCase());

        // Filter by specialization if selected
        bool matchesSpecialization = specialization == null || specialization.isEmpty || 
            clinic['specialization']!.toLowerCase().contains(specialization.toLowerCase());

        return matchesSearch && matchesSpecialization;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Extract a unique list of specializations
    Set<String> allSpecializations = {};
    for (var clinic in clinics) {
      allSpecializations.addAll(clinic['specialization']!.split(',').map((e) => e.trim()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.userName}', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.pink,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: (text) {
                  searchQuery = text;
                  filterClinics(searchQuery, selectedSpecialization);
                },
                decoration: InputDecoration(
                  hintText: 'Search for clinics...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            // Specialization Filter Dropdown
            DropdownButton<String>(
              value: selectedSpecialization,
              hint: Text("Select Specialization"),
              isExpanded: true,
              items: allSpecializations.map((specialization) {
                return DropdownMenuItem<String>(
                  value: specialization,
                  child: Text(specialization),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSpecialization = value;
                });
                filterClinics(searchQuery, value);
              },
            ),
            SizedBox(height: 16),
            // Clinic List with Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredClinics.length,
                itemBuilder: (context, index) {
                  final clinic = filteredClinics[index];
                  return Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(clinic['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(clinic['specialization']!, style: TextStyle(color: Colors.grey)),
                          Text(clinic['location']!, style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: Colors.green),
                              SizedBox(width: 4),
                              Text(clinic['hotline']!, style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.orange),
                              SizedBox(width: 4),
                              Text(clinic['distance']!, style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navigate to ClinicDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClinicDetailPage(clinic: clinic),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClinicDetailPage extends StatelessWidget {
  final Map<String, String> clinic;

  ClinicDetailPage({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic['name']!),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Clinic Name
              Text(
                clinic['name']!,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                clinic['location']!,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              
              // Specialization and Hotline Section
              _buildInfoCard(
                context,
                title: 'Specialization',
                value: clinic['specialization']!,
                icon: Icons.medical_services,
                iconColor: Colors.pink,
              ),
              SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: 'Hotline',
                value: clinic['hotline']!,
                icon: Icons.phone,
                iconColor: Colors.green,
              ),
              SizedBox(height: 16),
              _buildInfoCard(
                context,
                title: 'Distance',
                value: clinic['distance']!,
                icon: Icons.location_on,
                iconColor: Colors.blue,
              ),
              SizedBox(height: 24),
              
              // Description Section
              Text(
                'Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                clinic['description']!,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),

              // Book Appointment Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Booking Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(clinicName: clinic['name']!),
                    ),
                  );
                },
                child: Text('Book Appointment', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build info cards for sections like Specialization, Hotline, Distance
  Widget _buildInfoCard(BuildContext context, {required String title, required String value, required IconData icon, required Color iconColor}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(icon, color: iconColor, size: 32),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ),
    );
  }
}
class BookingPage extends StatefulWidget {
  final String clinicName;

  BookingPage({required this.clinicName});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // List to save the booking details
  List<Map<String, String>> _bookedAppointments = [];

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment at ${widget.clinicName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date and Time for Appointment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    hintText: _selectedDate == null
                        ? 'Tap to select a date'
                        : _selectedDate!.toLocal().toString().split(' ')[0],
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _selectTime,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    hintText: _selectedTime == null
                        ? 'Tap to select a time'
                        : _selectedTime!.format(context),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            if (_selectedDate != null || _selectedTime != null) ...[
              SizedBox(height: 16),
              Text(
                'You have selected:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (_selectedDate != null) ...[
                Text(
                  'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
              if (_selectedTime != null) ...[
                Text(
                  'Time: ${_selectedTime!.format(context)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ],
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: (_selectedDate == null || _selectedTime == null)
                  ? null
                  : () {
                      // Save the appointment details in the list
                      _bookedAppointments.add({
                        'clinicName': widget.clinicName,
                        'date': _selectedDate!.toLocal().toString().split(' ')[0],
                        'time': _selectedTime!.format(context),
                      });

                      // Navigate to the BookingDetailsPage with the saved appointments
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailsPage(
                            bookedAppointments: _bookedAppointments,
                          ),
                        ),
                      );
                    },
              child: Text('Confirm Appointment'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                primary: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BookingDetailsPage extends StatelessWidget {
  final List<Map<String, String>> bookedAppointments;

  BookingDetailsPage({required this.bookedAppointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bookedAppointments.length,
          itemBuilder: (context, index) {
            final appointment = bookedAppointments[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Appointment at ${appointment['clinicName']}'),
                subtitle: Text(
                    'Date: ${appointment['date']}\nTime: ${appointment['time']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        print('Login with: ${_emailController.text}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainTabController(
              userName: _nameController.text,
              userEmail: _emailController.text,
            ),
          ),
        );
      } else {
        print('Register with: ${_emailController.text}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(Icons.account_circle, size: 100, color: Colors.pink),
              SizedBox(height: 10),
              Text(
                _isLogin ? 'Welcome Back!' : 'Create an Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 30),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field (Always Visible)
                    _buildTextField(_nameController, 'Name', Icons.person, false, (value) {
                      if (!_isLogin && (value == null || value.isEmpty)) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                    SizedBox(height: 16),

                    // Email Field
                    _buildTextField(_emailController, 'Email', Icons.email, false, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                    SizedBox(height: 16),

                    // Password Field
                    _buildTextField(_passwordController, 'Password', Icons.lock, true, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    }),
                    SizedBox(height: 16),

                    // Confirm Password (Only for Register)
                    if (!_isLogin)
                      Column(
                        children: [
                          _buildTextField(_confirmPasswordController, 'Confirm Password', Icons.lock, true, (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                          SizedBox(height: 16),
                        ],
                      ),

                    // Login/Register Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(_isLogin ? 'Login' : 'Register', style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(height: 10),

                    // Toggle Between Login & Register
                    TextButton(
                      onPressed: _toggleAuthMode,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          _isLogin ? 'Don\'t have an account? Register' : 'Already have an account? Login',
                          key: ValueKey(_isLogin),
                          style: TextStyle(color: Colors.pink, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isObscure, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pink),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validator,
    );
  }
}
